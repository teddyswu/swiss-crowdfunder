# -*- encoding : utf-8 -*-
require 'net/http'
# include ToolsLibrary

def safely_and_compute_time
  beginning = Time.now
  # 用來解決資料庫 rufus_scheduler 連線 db 結束時, 不會中斷連線
  unless ActiveRecord::Base.connected?
    ActiveRecord::Base.connection.verify!(0)
  end
  message = yield
  spent   = Time.now - beginning
  SogiBuilder::CustomizedLog.write("jobs.log", "Time Spent:#{spent}, #{message}")
rescue Exception => e
  SogiBuilder::CustomizedLog.write("jobs.log", e.inspect)
ensure
  # 不管發生任何事, 最後 db 連線一定要清除到限制以內
  ActiveRecord::Base.connection_pool.release_connection
end

safely_and_compute_time do
  # scheduler  = Rufus::Scheduler.start_new
  # proc_mutex = Mutex.new # 初始化一個 process 鎖  
  # scheduler.cron '00 02 * * *', :mutex => proc_mutex do
  #   camp = Campaign.where(:result_status => nil).where("end_date < ?", Date.today)
  # end
end