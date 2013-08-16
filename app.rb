class ActivePost < Sinatra::Base
  set :public => "public", :static => true
  configure :production, :development do
    enable :logging
  end

  get '/' do
    "GO AWAY!"
  end

  get '/api/likes' do

    post = params[:post] || 1
    content_type :json
    {
      likes: $redis.get("likes.count.#{post}") || 0
    }.to_json
  end
end
