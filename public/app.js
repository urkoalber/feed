$( document ).ready( function(){
	$('#go').click( function(e){
		e.preventDefault();
		$('#empty').hide();
		$('#patents').show(); $('#academic').show(); $('#news').show();
		var googleUrl = 'http://google.com/patents?output=rss%26q=';
		var searchText = $('#search').val().replace(/ /g, '+');

		var xhr = $.getJSON('/api/feed?url=' + googleUrl + searchText, function(data){
			$('#patents').find('.loader').first().hide();
			$('#patents').append('<a href=' + data.url + '>' + data.title + '</a>');
		});
		return false;
	});
});
