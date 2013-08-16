ENV['RACK_ENV'] ||= 'development'
require 'resque'
require 'open-uri'
require './config/initializers/redis.rb'

class LikesWorker
  @queue = :default

  def self.perform
    post_id = "1397319907160290_1401265610099053"

    @access_token = "CAADA7ZC6pZBkUBAI8Lz0ZBYZBeFfNoRIodHOSl1OdHaVv494zzaEYq6KtsJZAQpPFFEZB07PGTbF5uB2vQDFuUp6Kv6F2B6rVrvio4ZA30mv1PIVKZAPF8xlHt0DZB2vlWoSZBRCxY1khDLA6rQX0LnXC6"
    post_object = open("https://graph.facebook.com/#{post_id}?fields=likes&access_token=#{@access_token}").read
    post_object = JSON.parse(post_object)

    $redis.set('likes.count.1', post_object['likes']['data'].count)
  end
end
