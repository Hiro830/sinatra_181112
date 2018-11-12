require 'sinatra'
require 'sinatra/reloader'
require 'json'
set :public_folder, 'public'


get '/' do
  # erb(:index) #erbがmethod :index が引数
  erb :index
end


json_path = File.dirname(__FILE__) + '/data/data.json'


get '/form' do
  @data = open(json_path) do |io|
    @data = JSON.load(io)
  end
  # @data.to_s
  erb :form
end



post '/form' do

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]
  File.open("./public/image/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end

  datum = {
    "name" => params[:name],
    "email" => params[:email],
    "content" => params[:content],

    "file" => params[:file][:filename]
  }

  data = []
  open(json_path) do |io|
    data = JSON.load(io)
  end

  data << datum

  open(json_path, 'w') do |io|
    JSON.dump(data, io)
  end

  redirect '/form'
  # redirect '/'
end






get "/image" do
  erb :image_form
end

post '/image' do
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]
  File.open("./public/image/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  puts params[:file]
  puts "あsdfsd"
  puts puts params[:file]
  erb :image_show

  # params[:file].to_s  #データ情報の確認
end
