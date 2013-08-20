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
    # Disabled cache
    response.headers['Expires'] = "Mon, 26 Jul 1997 05:00:00 GMT"
    response.headers['Cache-Control'] = "no-store, no-cache, must-revalidate"

    Resque.enqueue(LikesWorker)

    post = params[:post] || 1
    content_type :json
    {
      likes: ($redis.get("likes.count.#{post}") || 0).to_i
    }.to_json
  end
end

