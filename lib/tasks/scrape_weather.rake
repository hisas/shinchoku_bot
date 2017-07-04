require 'open-uri'
require 'nokogiri'
require 'twitter'

namespace :weather do
  desc "weather"
  task :weather => :environment do
    url = 'http://www.jma.go.jp/jp/yoho/319.html'
    doc = Nokogiri::HTML(open(url))
    # 気象庁から今日の18~24時の降水確率を取得
    rainy_percent = doc.css('//table[@class="rain"]//tr//td')[7].children.text.chop.to_i
    # 降水確率が60%以上の時にツイート
    if rainy_percent >= 60
      @twitter = twitter_client
      tweet = "@hisas_jp 今日の夕方以降の降水確率は#{rainy_percent}%です。🌂を持っていきましょう！"
      @twitter.update(tweet)
    end
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
