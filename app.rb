require 'json'
require 'job'

class ActivePost < Sinatra::Base
  set :public => "public", :static => true
  set :protection, :except => [:json_csrf]
  configure :production, :development do
    enable :logging
  end

  get '/' do
    "GO AWAY!"
  end

  get '/api/likes' do
    Resque.enqueue(LikesWorker)

    post = params[:post] || 1
    content_type :json
    {
      likes: ($redis.get("likes.count.#{post}") || 0).to_i
    }.to_json
  end
end

