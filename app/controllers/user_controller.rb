class UserController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :"posts/index"
    end
  end
end
