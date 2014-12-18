# app.rb
require "sinatra"
require "feedjira"
require "json"

get '/' do
  @search = params[:search] || ''
  @patt = /<font.*>.* (.*)<\/font>/i
  
  if @search == ''
    @empty = 'Introduce los términos de búsqueda'
  else
    url = 'http://www.google.com/patents?q=' + @search.gsub(' ', '+') + '&output=rss'
    @feed = Feedjira::Feed.fetch_and_parse(url)    
  end
  
  haml :index
end


