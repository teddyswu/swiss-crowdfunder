# OffsitePayments::Integrations::Allpay.setup do |allpay|
#   if Rails.env.development?
#     # default setting for stage test
#     allpay.merchant_id = '2000132'
#     allpay.hash_key    = '5294y06JbISpM5x9'
#     allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
#   else
#     # change to yours
#     allpay.merchant_id = '7788520'
#     allpay.hash_key    = 'adfas123412343j'
#     allpay.hash_iv     = '123ddewqerasdfas'
#   end
# end
OffsitePayments::Integrations::Allpay::Helper.module_eval do
  def encrypted_data
    raw_data = @fields.sort.map{|field, value|
      # utf8, authenticity_token, commit are generated from form helper, needed to skip
      "#{field}=#{value}" if field!='utf8' && field!='authenticity_token' && field!='commit'
    }.join('&')

    hash_raw_data = "HashKey=#{OffsitePayments::Integrations::Allpay.hash_key}&#{raw_data}&HashIV=#{OffsitePayments::Integrations::Allpay.hash_iv}"
    url_encode_data = self.class.url_encode(hash_raw_data)
    url_encode_data.downcase!

    binding.pry if OffsitePayments::Integrations::Allpay.debug

    add_field 'CheckMacValue', Digest::SHA256.hexdigest(url_encode_data).upcase
  end
end
OffsitePayments::Integrations::Allpay::Notification.module_eval do
	def checksum_ok?
    params_copy = @params.clone

    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: #{params_copy} \n---------------------------------------------\n\n))
    end
    checksum = params_copy.delete('CheckMacValue')
    
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 1: #{checksum} \n---------------------------------------------\n\n))
    end

    # 把 params 轉成 query string 前必須先依照 hash key 做 sort
    # 依照英文字母排序，由 A 到 Z 且大小寫不敏感

    raw_data = params_copy.sort_by { |k,v| k.downcase }.map do |x, y|
      "#{x}=#{y}"
    end.join('&')

    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 2: #{raw_data} \n---------------------------------------------\n\n))
    end

    hash_raw_data = "HashKey=#{OffsitePayments::Integrations::Allpay.hash_key}&#{raw_data}&HashIV=#{OffsitePayments::Integrations::Allpay.hash_iv}"
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 3: #{hash_raw_data} \n---------------------------------------------\n\n))
    end
    url_encode_data = OffsitePayments::Integrations::Allpay::Helper.url_encode(hash_raw_data)

    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 4: #{url_encode_data} \n---------------------------------------------\n\n))
    end
    url_encode_data.downcase!
    
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 5: #{url_encode_data.downcase!} \n---------------------------------------------\n\n))
    end

    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601} 6: #{Digest::SHA256.hexdigest(url_encode_data)} \n---------------------------------------------\n\n))
    end

    (Digest::SHA256.hexdigest(url_encode_data) == checksum.to_s.downcase)
  end 
end


OffsitePayments::Integrations::Allpay.module_eval do
	def self.service_url
    pay = YAML.load_file("config/settings.yml")
		pay[:service_url]
	end
end
OffsitePayments::Integrations::Allpay.setup do |allpay|
  pay = YAML.load_file("config/settings.yml")
  # default setting for stage test
  allpay.merchant_id = pay[:merchant_id]
  allpay.hash_key    = pay[:hash_key]
  allpay.hash_iv     = pay[:hash_iv]
end