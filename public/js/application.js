$(document).ready(function(){
	$("#unAuthShortenForm").submit(function(e){
		e.preventDefault();
		$('#shorten_btn').val('..in progress..');

		//ajax call Post instead of form

		$.ajax({
			url: '/urls',
			method: 'POST',
			data: $(this).serialize(),
			dataType: 'json',
			success: function(data){
				$('#shorten_btn').val('DONE');
				$('.info-msg').text("");
				//$('.info-msg').text("Your short url is : "+data.short_url);

				setTimeout(function(){$('#shorten_btn').val('SHORTEN'); }, 1000);
				var new_item = $('<li class="shortened_link"><div class="unauth-title"> <a class="article-title" href="'+data.long_url+'" target="_blank" >'+ data.long_url+'</a> </div><div class="unauth_capsule clearfix"> <a class="short-url" href="'+data.short_url+'" target="_blank" >'+ data.short_url+'</a> <p class="count">short url click count: '+data.click_count+'</p></div></li>');
				$('ul').prepend(new_item);
				new_item.show('normal');
			},
			error: function(data){
				$('#shorten_btn').val('SHORTEN');
				$('.info-msg').text("Invalid url!");
				$('.info-msg').effect("highlight");
			}
		});
	});
});



$(document).ready(function(){
	$("body").on("click", ".short-url", function() {


		url_id = $(this).data('id')
		p = $('#click-count-' + url_id)
		click_count = p.data('count') + 1
		p.text('short url click count: ' + click_count);
		p.data('count', click_count);

		
	});

});





