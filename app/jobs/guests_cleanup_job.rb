class GuestsCleanupJob < ApplicationJob
  queue_as :low_priority
  # ...
end

# 以上で、production環境ではproduction_low_priorityというキューでジョブが
# 実行されるようになり、staging環境ではstaging_low_priorityというキューで
# ジョブが実行されるようになります