# app/jobs/my_job.rb
class MyJob < SolidQueue::Job
  def perform(arg1)
    puts "Job executed with arg1=#{arg1}"
  end
end
