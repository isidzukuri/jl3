window.jl_i18n = {
	lang:{
		'error' : 'Błąd!',
		'require_all_fields': 'Sprawdź, czy wszystkie pola wypełnione poprawnie.',
		'reload_page_and_try_again': 'Proszę, odśwież stronę i spróbuj jeszcze raz.',
		'error_reload_and_download': 'Proszę, odświeżyć stronę i spróbuj ponownie pobrać plik.',
		'error_reload_and': 'Błąd! Proszę odświeżyć stronę i spróbować ...',
		'error_reload_and_repeat': 'Błąd! Proszę spróbować przeładowacz strony i powtórzyć czynność.',
		'alf': 'aąbcćdeęfghijklłmnńoóprsśtuwyzźż',
		'added': 'dodane!',
		'search': 'Szukaj',
		'at_least_one_site': 'Wybierz serwis',
		'error_reload_and_repeat': 'Proszę, przeładuj strony i spróbuj ponownie szukać.',
		'delete_user': 'Czy na pewno chcesz usunąć swoje konto?',
		'email_error': 'Proszę podać poprawny adres e-mail',
	},
	translate: function(key){
		return typeof this.lang[key] != 'undefined' ? this.lang[key] : key;
	}
}