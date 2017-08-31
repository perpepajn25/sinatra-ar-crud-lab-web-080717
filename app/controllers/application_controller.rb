require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id/edit' do
    @post = Post.find_by(id: params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect to "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    @post=Post.find_by(id: params[:id]).delete
    erb :delete
  end

  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end

  post '/posts' do
    @post = Post.create(params)
    redirect to "/posts"
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

end
