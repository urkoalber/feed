# app.rb
require "sinatra"
require "feedjira"
require "json"

get '/' do
  @empty = 'Introduce los términos de búsqueda'  
  @patt = /<font.*>.* (.*)<\/font>/i  
  
  haml :index
end

get '/api/feed' do
  content_type :json
  url = params[:url]
      
  feed = Feedjira::Feed.fetch_and_parse(url)
  feed_object = { :title => "#{feed.title}", :url => "#{feed.url}", :description => "#{feed.description}", :items => [] }
  feed.entries.each do |entry|
    entry_object = {:title => "#{entry.title}", :url => "#{entry.url}", :summary => "#{entry.summary}"}
    feed_object[:items] << entry_object
  end    
  
  feed_object.to_json
end


