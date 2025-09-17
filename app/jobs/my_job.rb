class MyJob < ApplicationJob
  queue_as :default

  def perform(arg1:)
    # ここにジョブで実行したい処理を書く
    puts "Job executed with arg1=#{arg1}"
  end
end