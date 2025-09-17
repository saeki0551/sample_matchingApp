class CreateSolidQueueJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string   :queue
      t.string   :job_class
      t.text     :args
      t.integer  :attempts, default: 0
      t.datetime :run_at
      t.datetime :failed_at
      t.timestamps
    end
  end
end
