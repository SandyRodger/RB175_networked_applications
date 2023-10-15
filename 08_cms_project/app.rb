require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"
require "byebug"

# before do
#   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
# end

configure do
  enable :sessions
  set :session_secret, "800c27b02a1305bca0948568288d4dd682e40c8e0c45d96e2e5e0a72f84594d01f"
end

root = File.expand_path("..", __FILE__)

helpers do

  def load_list(id)
    File.readlines("data/#{id}")
  end

  def render_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text)
  end
end

get "/" do
  @files = Dir.glob(root + "/data/*").map do |path|
    File.basename(path)
  end
  erb :index
end

get "/:filename" do
  file_path = root + "/data/" + params[:filename]
  if File.exist?(file_path)
    if File.extname(file_path) == ".md"
      headers["body"] = render_markdown(File.read(file_path))
    else
      headers["Content-type"] = "text/plain"
      File.read(file_path)
    end
  else
    session[:not_found] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

