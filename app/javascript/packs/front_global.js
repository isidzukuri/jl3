$(function() {
	window.reload_after_alert = false;
	window.overlay = $('#global_popup');
	window.big_loader = $('.book_loader');
	window.retry_after_auth_buttons = $('.retry_after_auth');
	window.default_lil_loader = '<div class="lil_loader"></div>'; //after content
	window.lil_loader_html = '<div class="b_loader"><div class="lil_loader"></div></div>'; //over content
	window.global_rising_block = $('#global_rising_block');
	window.cancel_global_rising_block = $('#cancel_global_rising_block');
	window.allow_check_last_rate = true;
	window.suggest_book = $(window).width() > 768;


    
    $('input, textarea').focus(function(){
    	if($(this).hasClass('not_default_input')) return;
        def_val = $(this)[0].defaultValue;
        if ($(this).val() == def_val) $(this).val('');
    });
    
    $('input, textarea').blur(function(){
    	if($(this).hasClass('not_default_input')) return;
        def_val = $(this)[0].defaultValue;
        if ($(this).val() == '') $(this).val(def_val);
    });

    $('#alert_popup .button').click(function(){
    	hide_alert();
    });

    $('.submit_btn').click(function(){
		submitform($(this).parents('form'),false,$(this));
		return false;
	});

    $('.search_submit_but').click(function(){
		$(this).parents('form').submit();
		return false;
	});

	$('#sbox form').submit(function(){
		show_big_loader();
	});

	window.cancel_global_rising_block.click(function(){
		hide_global_rising();
		return false;
	});

	attach_auth_buttons();

	setTimeout(function(){
		window.user_id ? check_last_rate() : suggest_paper();
	}, 7000);
    
    new Image().src = "https://counter.yadro.ru/hit?r"+
	escape(document.referrer)+((typeof(screen)=="undefined")?"":
	";s"+screen.width+"*"+screen.height+"*"+(screen.colorDepth?
	screen.colorDepth:screen.pixelDepth))+";u"+escape(document.URL)+
	";"+Math.random();

	$(window).load(function(){
		(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.async = true;
		  js.src = "//connect.facebook.net/"+window.sokrat_js_config.locale+"/all.js#xfbml=1";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.async = true;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
		
		window.___gcfg = {lang: window.sokrat_js_config.language};
		
		(function() {
			var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
			po.src = 'https://apis.google.com/js/plusone.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		})();

		sr_fb_height = $('#sideRight').height() > 30 ? 630 : $('#sideRight').height();
		// $('#sideRight').simpleFixedblock({
		//     'ss_fb_height'   : sr_fb_height
		// });
	});
	
});

function attach_auth_buttons(){
	$(retry_after_auth_buttons.selector).click(function(){
		show_auth_window($(this));
		return false;
	});
}

function captcha_ensure(button){
	window.proceed = false;
	form_loader = button.parents('form').find('.b_loader');
	form_loader.show();
	button.hide();
	controller = button.data('controller');
	captcha_id = $('input[name=captcha_id]').val();
	captcha = $('input[name=captcha]').val();
	$.ajax({
      async: false,
	  dataType: 'json',
	  type: "POST",
	  url: '/'+controller+'/captchacheck',
	  data: button.parents('form').serialize(),
	  error: function(){ 
	    form_loader.hide();
		button.show();
	  	show_alert(window.sokrat_i18n.translate('error'), window.sokrat_i18n.translate('reload_page_and_try_again'));
	  },
	  success: function( msg ) {
		if(msg.status){
			window.proceed = true;
		}else{
			if(msg.message) show_alert(window.sokrat_i18n.translate('error'), msg.message);
			new_img = '/uploads/captcha/'+msg.new_id+'.png';
			$('input[name=captcha_id]').val(msg.new_id);
			button.parents('form').find('.captcha_img').attr('src',new_img);
			form_loader.hide();
			button.show();
		}
	  }
	});
};

function show_alert(title,msg){
	window.popup_title = $('.popup_wrap p');
	window.err_popup = $('#alert_popup');
	window.err_body = $('.popup_text');
	popup_title.addClass('red_h2').html(title); 
	err_body.find('p').empty().html(msg);
	overlay.show().animate({
			'opacity': '1'
		},300,function(){
			err_popup.show().animate({'opacity': '1'},300);
			err_body.delay(300).animate({'height': '155px'},500);
	});
	attach_auth_buttons();
}

function hide_alert(){
	if(window.reload_after_alert) location.reload(true);
	err_body.animate({'height': '0px'},300);
	setTimeout(function() { 
		err_popup.animate({'opacity': '0'},300,function(){err_popup.hide();});
		background_needed_for = ['to_bookmark', 'jump_to_bookmark', 'get_user_bookmark'];
		if(background_needed_for.indexOf(window.last_retry_function_name) < 0) overlay.delay(300).animate({'opacity': '0'},300,function(){
			overlay.hide();
			popup_title.removeClass('red_h2').empty(); 
			err_body.find('p').empty();
		});
	}, 300);
}

function submitform(form,msg,button){
	validator = form.validate({ignore: '.ignore'})
	if(validator.form()){
		if(button.hasClass('captcha_ensure')){
			captcha_ensure(button);
			if(!proceed) return false;
		}
		form.submit()
	}else{
		show_alert(window.sokrat_i18n.translate('error'), window.sokrat_i18n.translate('require_all_fields'));
	}
}

function show_big_loader(){
	overlay.show().animate({
			'opacity': '1'
		},150,function(){
			big_loader.show().animate({'opacity': '1'},200);
	});
};

function dotting(text_block, dots){
	if(typeof dots == 'undefined') dots = 5
	dot_span = text_block.append("<span class='dotting'></span>").find('.dotting');
	setInterval(function(){ 
		if(dot_span.text().split('').length == dots) dot_span.empty()
		dot_span.append('.');
	}, 1000);
}

function setLocation(loc){
	try {
		history.pushState(null, null, loc);
		return false;
	} catch(e) {}
		location.hash = '#' + loc;
}

function show_auth_window(button){
	if(typeof button == 'undefined'){
		href = '/user';
	}else{
		href = button.attr('href');
	}
	if(typeof window.retry_function != 'undefined') set_jl_cookie('retry_after_auth', 1);
	window.open(href+'#container','authorization','width=1060, height=550, menubar=0');
}

function retry_after_auth(){
	setTimeout(function() {hide_alert(); }, 300);
	window.retry_function.callee.apply(undefined, window.retry_function);
	window.last_retry_function_name = window.retry_function.callee.name;
	delete window.retry_function;
}

function set_jl_cookie(name, val, minutes){
	if(typeof minutes == 'undefined') minutes = 60;
	date = new Date();
	date.setTime(date.getTime() + (minutes * 60 * 1000));
	$.cookie(name, val, { path: '/', expires: date});
}


function check_cookie_time(key){
	return (!$.cookie(key) || (parseInt($.cookie(key)) + 300 < Math.floor(new Date().getTime() / 1000) ));
	// return true
}

function suggest_paper(){
	if(window.suggest_book && parseInt(window.sokrat_js_config.force_user) && check_cookie_time('suggest_book_time')){
		$.ajax({
		  dataType: 'json',
		  type: "POST",
		  url: '/book/suggestpaper',
		  error: function(){},
		  success: function( msg ) {
			if(msg.status) {
				window.global_rising_block.find('.append_here').append(msg.html);
				window.global_rising_block.show();
				show_global_rising();
			}else{
				window.suggest_book = false;
			}
		  }
		});		
	}
}

function check_last_rate(){
	if(window.user_id && parseInt(window.sokrat_js_config.force_user) && window.allow_check_last_rate && check_cookie_time('last_rate')){
		$.ajax({
		  dataType: 'json',
		  type: "POST",
		  url: '/cabinet/checklastrate',
		  data: {'user_id':window.user_id},
		  error: function(){},
		  success: function( msg ) {
			if(msg.status) {
				window.global_rising_block.find('.append_here').append(msg.html);
				window.global_rising_block.show();
				atach_stars_controls();
				show_global_rising();
			}else{
				window.allow_check_last_rate = false;
			}
		  }
		});
	}
}


function atach_stars_controls(){
	window.stars = $('.global_rating_stars.rating_stars .stars div');
	window.stars_wrap = $('.global_rating_stars.rating_stars');
	stars.hover(
	  function() {
	    $(this).parent().addClass('stars_'+$(this).attr('rate'))
	  }, function() {
	    $(this).parent().removeClass('stars_'+$(this).attr('rate'))
	  }
	);

	stars.click(function(){
		global_rate_book($(this));
		return false;
	});

	count_global_votes_width();
}


function count_global_votes_width(){
	total_width = 0;
	$('.vote_please > div').each(function( index ) {
	  total_width += $(this).outerWidth(true);
	});
	window.global_rising_block.find('.append_here').css('width',total_width);
}


function show_global_rising(){
	window.global_rising_block.show().animate({
			'marginTop': -window.global_rising_block.height()
		},550);
}


function hide_global_rising(){
	window.global_rising_block.animate({
			'marginTop': 0
		},450,
		function(){window.global_rising_block.hide().find('.append_here').css('width','auto').empty();}
	);
}


function show_vote_thanks(){
	height = window.global_rising_block.find('.append_here').height();
	$('.vote_please').hide();
	window.global_rising_block.find('.vote_please_thanks').css('line-height',height+"px").show();
	setTimeout(function(){ hide_global_rising(); }, 4000);
}
	

function global_rate_book(star){
	show_vote_thanks();
	rate = parseInt(star.attr('rate'));
	$.cookie('last_rate', Math.floor(new Date().getTime() / 1000),{ path: '/' });
	$.cookie('java-book', global_cookie_string,{ path: '/' });
	$.ajax({
	  dataType: 'json',
	  type: "POST",
	  url: "/ratebook",
	  data: {"rate" : rate},
	  error: function(){},
	  success: function( msg ) {}
	});
}



jQuery.fn.extend({
  renameAttr: function( name, newName, removeData ) {
    var val;
    return this.each(function() {
      val = jQuery.attr( this, name );
      jQuery.attr( this, newName, val );
      jQuery.removeAttr( this, name );
      // remove original data
      if (removeData !== false){
        jQuery.removeData( this, name.replace('data-','') );
      }
    });
  }
});
