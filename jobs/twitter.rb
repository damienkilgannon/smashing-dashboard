require 'twitter'


client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET_KEY"]
  config.access_token = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

twitter_username = ENV['TWITTER_USERNAME'] || 'foobugs'

SCHEDULER.every '2s', :first_in => 0 do |job|
  begin
    user = client.user('damienkilgannon')
    send_event('followers', { current: user.followers_count, last: user.followers_count })
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
