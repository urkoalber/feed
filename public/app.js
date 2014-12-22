$( document ).ready( function(){
	function loadData(url, searchText, destination) {
		$.getJSON('/api/feed?url=' + url + searchText, function(data){
			$(destination).find('.loader').first().hide();
			var listData = '<div class="feed"><a href=' + data.url + '>' + data.title + '</a><ul>';
			for(var i=0; i < data.items.length; i++){
				var item = data.items[i];
				listData += '<li><a href=' + item.url + '>' + item.title + '</a><p>' + item.summary + '</p></li>';
			}
			listData += '</ul></div>';
			$(destination).find('.data').append(listData);
		});
	}
	
	$('#go').click( function(e){
		e.preventDefault();
		$('#empty').hide();
		$('#patents').show(); $('#academic').show(); $('#news').show();		
		var searchText = $('#search').val().replace(/ /g, '+');
		
		var googleUrl = 'http://google.com/patents?output=rss%26q=';		
		loadData(googleUrl, searchText, '#patents');
		
		var microsoftUrl = 'http://academic.research.microsoft.com/Rss?end=15%26query=';
		loadData(microsoftUrl, searchText, '#academic');
		
		var yahooUrl = 'http://es.news.search.yahoo.com/rss?p=';
		loadData(yahooUrl, searchText, '#news');
		
		return false;
	});
});
