window.jl_i18n = {
	lang:{
		'error' : 'Error!',
		'require_all_fields': 'Check that all the fields filled correctly.',
		'reload_page_and_try_again': 'Please refresh page and try again.',
		'error_reload_and_download': 'Please reload the page and try again to download the file.',
		'error_reload_and': 'Error! Please reload the page and ...',
		'error_reload_and_repeat': 'Error! Please try reload page and repeat the action.',
		'alf': false,
		'added': 'added!',
		'search': 'Search',
		'at_least_one_site': 'Select at least one site for search',
		'error_reload_and_repeat': 'Please reload the page and try the search again.',
		'delete_user': 'Are you sure you want to delete your account?',
		'email_error': 'Enter a valid Email',
	},
	translate: function(key){
		return typeof this.lang[key] != 'undefined' ? this.lang[key] : key;
	}
}