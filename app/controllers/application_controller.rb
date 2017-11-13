
require 'pry'
require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "secret"
  end

  get "/" do
		erb :index
	end

	get "/signup" do
    binding.pry
    if logged_in?
      redirect to "/tweets"
		else
      erb :signup
    end
	end

	post "/signup" do
    if params.values.any?{|v| v.nil? || v.length == 0}
      redirect to "/signup"
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    end
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/success"
    else
      redirect "/failure"
    end
	end

	get "/success" do
		if logged_in?
			redirect to "/tweets"
		else
			redirect to "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
