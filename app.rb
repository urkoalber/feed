# app.rb
require "sinatra"
require "feedjira"
require "json"

def build_routes(routes, search)
  urls = []
  routes.each do |route|
    urls << route + search.gsub(' ', '+')
  end
  urls
end

def build_json_result(feed)
    
end

get '/' do
  patents_routes = [      
    'http://es.espacenet.com/websyndication/searchFeed?DB=lp.espacenet.com&query=',
    'http://www.google.es/patents?output=rss&q='    
  ]
  news_routes = [
    'http://es.news.search.yahoo.com/rss?p='
  ]
  academic_routes = [
    'http://academic.research.microsoft.com/Rss?end=10&query='
  ]
  
  @search = params[:search] || ''
  @patt = /<font.*>.* (.*)<\/font>/i
  
  if @search == ''
    @empty = 'Introduce los términos de búsqueda'
  else
    @patents = Feedjira::Feed.fetch_and_parse(build_routes(patents_routes, @search))    
    @academic = Feedjira::Feed.fetch_and_parse(build_routes(academic_routes, @search))
    @news = Feedjira::Feed.fetch_and_parse(build_routes(news_routes, @search))
  end
  
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


