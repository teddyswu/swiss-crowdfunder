# -*- encoding : utf-8 -*-
require "net/http"
require "cgi"
require "rexml/document"

module SogiBuilder
	class CustomizedLog
    def self.write(file_name, string)
      File.open("#{Rails.root}/log/#{file_name}", "a+") do |file|
        file.syswrite(%(#{Time.now.iso8601}: #{string} \n---------------------------------------------\n\n))
      end
    end
  end
end