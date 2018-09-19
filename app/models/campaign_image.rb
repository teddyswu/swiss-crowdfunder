class CampaignImage < ApplicationRecord
	mount_uploader :file, CampaignImageUploader
	belongs_to :campaign

	def update_urls_success?
    begin
      puts "file is #{self.file.present?}"
      # 這邊就寫, 如果 file 存在, 就 update url 要不然就不要 update
      if self.file.present?
        # s3_host = "https://sogi-channel.s3.amazonaws.com"
        update_datas = {
          :landing_page => self.file.landing_page.url,
          :campaign_path   => self.file.campaign_path.url,
        }
        if self.update_attributes( update_datas )
          return true
        else
          return false
        end
      end
    rescue Exception => e
      logger.error("Uploader Error!! cannot update url")
      logger.error("==================================")
      logger.error(e)
      logger.error("==================================")
      return false
    end
  end
end
