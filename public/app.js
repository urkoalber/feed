$( document ).ready( function(){
	$('#go').click( function(e){
		var googleUrl = 'http://google.com/patents?output=rss&q=';
		var searchText = $('#search').val().replace(/ /g, '+');
		var xhr = $.getJSON(googleUrl + searchText, function(){
			$('main').append('<h1>OK!!!!!!!!!!</h1>');
		});
	});
});
