class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :"posts/index"
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    erb :"posts/new"
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    erb :"posts/show"
  end

  post "/tweet" do
    if !params[:content].nil?
      tweet = Tweet.create(params[:content])
      tweet.user_id = current_user.id
      redirect to "/tweet/#{tweet.id}"
    else
      erb :"posts/new"
    end
  end

  delete '/tweets/:id/delete' do #delete action
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.delete
  redirect to '/tweets'
  end

end
