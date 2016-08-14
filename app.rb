require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/param'
require './to_do_list'
require './user'
require './list_item'

set :database, {adapter: "sqlite3", database: "todolists.sqlite3"}

STYLE = <<-STYLE
  h1 {
    color: blue;
    margin-left: 50px;
    margin-right: 50px;
    margin-top: 25px;
    margin-bottom: 25px;
  }
  p {
    margin: 100px;
  }
STYLE

HEADER = "My App"

get '/hi' do
  "Hi there!\n"
end

post '/users' do
  param :first_name, String
  param :last_name, String

  @user = User.create!(first_name: params[:first_name], last_name: params[:last_name])

  erb :show_user
  # status 200
  # user.to_json
end

get '/users/new' do
  erb :user_form
end

get '/users/:id' do
  @user = User.find(params[:id])
  # @style = STYLE
  erb :show_user
end

get '/lists/new' do
  erb :list_form
end

post '/lists' do
  param :name, String
  param :user_id, Integer

  @list = ToDoList.create!(name: params[:name], user_id: params[:user_id])
  erb :show_list

  # status 200
  # list.to_json
end

# get '/lists/:user_id' do
#   lists = ToDoList.where(user_id: params[:user_id])
#   status 200
#   { lists: lists }.to_json
# end

get '/lists/:id' do
  @list = ToDoList.find(params[:id])
  erb :show_list
  # status 200
  # list.to_json
end

post '/list_items' do
  param :title, String
  param :list_id, Integer

  list_item = ListItem.create!(title: params[:title], list_id: params[:list_id])
  status 200
  list_item.to_json
end

get '/list_items/:list_id' do
  list_items = ListItem.where(list_id: params[:list_id])
  status 200
  { list_items: list_items }.to_json
end

get '/list_items/:list_id/completed' do
  list_items = ListItem.where(list_id: params[:list_id], completed: false)
  status 200
  { list_items: list_items }.to_json
end

put '/list_items' do
  param :id, Integer
  param :completed, :boolean

  list_item = ListItem.find(params[:id])
  list_item.update_attribute(:completed, params[:completed])
  status 200
  list_item.to_json
end
