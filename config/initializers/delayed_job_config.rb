silence_warnings do
  Delayed::Job.const_set("MAX_ATTEMPTS", 1)
end