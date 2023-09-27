require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "byebug"

contents = Dir.entries('/Users/sandyboy/Desktop/RB175_networked_applications/03_working_with_sinatra/04_code_challenge_dynamic_directory_index/data').sort

get "/" do
  @contents = contents

  erb :home

end

get "/reverse_alphabet" do
  @contents = contents.reverse

  erb :home

end

contents.each do |filename|
  get "/#{filename}" do
    @title = filename
    @file= File.read("data/#{filename}")
  end
end
