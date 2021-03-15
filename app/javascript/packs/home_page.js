$(function() {
	$(window).load(function(){

		if($('#recomended_slider').size() > 0) {
			$('#recomended_slider').simpleSlider({
					hd_time : 500,
					hd_slide_shown : 1
			});
		}

		if($('#last_slider').size() > 0) {
			last_slides = $(window).width() < 768 ? 1 : 3;

			$('#last_slider').simpleSlider({
					hd_time : 500,
					hd_slide_shown : last_slides
			})
		}
	});
});

