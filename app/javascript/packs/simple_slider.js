(function( $ ){

  $.fn.simpleSlider = function( options ) {  

    var settings = $.extend( {
      'hd_time'         : 500,
      'hd_slide_shown' : 3,
      'easing' : 'easeOutCubic'
    }, options);

    return this.each(function() {  
    	window.ss_slider_x = 0;
    	slider = $(this);
    	set_width(slider);
    	slider.find('>div').wrap('<div class="simple_slider_item" /></div>');
    	slider.addClass('simple_slider').wrapInner('<div class="simple_slider_inner" />').wrapInner('<div class="simple_slider_wrap" />').append('<a class="controll_arrow left_arrow"></a><a class="controll_arrow right_arrow"></a><div class="ss_slider_clear"></div>');
    	slider_values(slider);
		hd_wrap.width(hd_lenght*hd_step);
    	hd_left.click(left_click);
    	hd_right.click(right_click);
    });

    function set_width(slider){
    	width = 0;
    	slider.find('>div:first-child>*').each(function(index) {
		    width += parseInt($(this).width()) + parseInt($(this).css('margin-right')) + parseInt($(this).css('margin-left'));
		});
    	margin = (parseInt(slider.css('width')) - width)/2;
    	slider.find('>div').css('width', width+'px');
    	if(settings.hd_slide_shown == 1) slider.find('>div').css('margin', '0px '+margin+'px');
    }

    function slider_values(slider){
    	hd_left = slider.find('.left_arrow');
		hd_right = slider.find('.right_arrow');  
		hd_wrap = slider.find('.simple_slider_inner'); 
		hd_item = hd_wrap.find('.simple_slider_item');	
		hd_max_step = settings.hd_slide_shown;
		hd_lenght = hd_item.length;
		hd_time = settings.hd_time;
		hd_step = hd_item.width() + parseInt(hd_item.css('margin-left')) + parseInt(hd_item.css('margin-right'));
		easing = settings.easing;
    }
		
	function right_click(){
    	slider_values($(this).parents('.simple_slider')); 
		if(ss_slider_x == 0){
			ss_slider_x=1;
			if( -parseInt(hd_wrap.css('margin-left')) == hd_step *(hd_lenght - hd_max_step)){
			hd_wrap.animate({'margin-left': '-='+30},parseInt(hd_time/3),easing,function(){hd_wrap.animate({'margin-left': '+='+30},parseInt(hd_time/3),easing)});
		}else{
			cur_marg = parseInt(hd_wrap.css('margin-left'));
			if( cur_marg -( hd_step * hd_max_step) > -(hd_step * hd_lenght - hd_step * hd_max_step) ){
				marg = '-='+hd_step * hd_max_step;
			}else{
				marg = -(hd_step * hd_lenght - hd_step * hd_max_step)
			}
			hd_wrap.animate({'margin-left': marg},hd_time,easing);
		}
			setTimeout(function(){ss_slider_x = 0}, hd_time);
		}
	};
	
	function left_click(){
		slider_values($(this).parents('.simple_slider'));
		if(ss_slider_x == 0){
			ss_slider_x=1;
			if(parseInt(hd_wrap.css('margin-left')) == 0){
			hd_wrap.animate({'margin-left': '+='+30},parseInt(hd_time/3),easing,function(){hd_wrap.animate({'margin-left': '-='+30},parseInt(hd_time/3),easing)});
		}else{
			cur_marg = parseInt(hd_wrap.css('margin-left'));
			if( cur_marg +( hd_step * hd_max_step) < 0 ){
				marg = '+='+hd_step * hd_max_step;
			}else{
				marg = 0;
			}
			hd_wrap.animate({'margin-left': marg},hd_time,easing);
		}
			setTimeout(function(){ss_slider_x = 0}, hd_time);
		}
	};


  };
})( jQuery );