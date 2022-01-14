class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignoreif
  # if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
