require "openai"

OpenAI.configure do |config|
  configaccess_token = ENV["OPENAI_ACCESS_TOKEN"]
  config.log_errors = true
end
