require 'twitter'

namespace :twitter do
  desc "tweet"
  task :tweet => :environment do
    client = twitter_client
    tweet = "今日も一日お疲れ様でした！😊"
    client.update(tweet)
  end
end

def twitter_client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TEITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
  end
end
