require 'twitter'

namespace :twitter do
  desc "tweet"
  task :tweet => :environment do
    @twitter = twitter_client
    @github = github_client
    tweet = "@hisas_jp 今日も一日お疲れ様でした！😊 今日は#{contributions_count}contributionsでした。"
    @twitter.update(tweet)
  end
end

def twitter_client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
  end
end

def github_client
  Octokit::Client.new(:access_token => ENV["GITHUB_ACCESS_TOKEN"])
end

def contributions_count
  count = 0
  @github.user_events("hisas").each do |event|
    if event[:created_at] > Time.current - 60*60*10
      count += 1
    end
  end
  return count
end
