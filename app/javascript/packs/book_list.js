$(function() {
    // $('.list_actions a').click(function(){
    //     add_to_default_list($(this));
    // });

    $('.sort_book_list .sort_button').click(function(){
        $(".sort_book_list .sort_button").removeClass('active');
        $(this).addClass('active');

        sort_type = $(this).data("sort_type");
        sort_types = {
            'name' :'.genrhru .flink',
            'title' : '.genrhru .booklink',
            'size' : '.genrhru .file_size_list'
        }
        direction_types = {'asc':'↑', 'desc':'↓'};
        new_direction = $(this).data("direction") == 'desc' ? 'asc' : 'desc';
        $(this).find('span').text(direction_types[new_direction]);
        $(this).data("direction", new_direction);
        sort_params = {order:new_direction};
        if(sort_type == 'size'){ 
            sort_params.sortFunction = function(a,b){
                numberPattern = /\d+/g;
                iCalcA = parseInt(a.s[0].match(numberPattern));
                iCalcB = parseInt(b.s[0].match(numberPattern));
                compare = new_direction == 'desc' ? iCalcA<iCalcB : iCalcA>iCalcB 

                return iCalcA===iCalcB? 0 : (compare ? 1: -1);
            }
        }else{
            sort_params.charOrder = window.jl_i18n.translate('alf');
        }
        $(".book_list .bookblock").tsort(sort_types[sort_type], sort_params );
        return false;
    });
});

// function add_to_default_list(button){
//     if(button.hasClass('green_added')) return false;
//     window.retry_function = arguments;
//     button.append(window.default_lil_loader);
//     book = button.parents('.bookblock');
//     $.ajax({
//       dataType: 'json',
//       type: "POST",
//       url: '/book/addtodefaultlist',
//       data: {"id" : book.attr('data-book_id'), "type" : button.attr('data-list_type')},
//       error: function(){ 
//         button.empty();
//         show_alert(window.sokrat_i18n.translate('error'),window.sokrat_i18n.translate('error_reload_and_repeat'));
//       },
//       success: function( msg ) {
//         button.empty();
//         if(msg.status){
//             button.attr('title',window.sokrat_i18n.added).attr('alt',window.sokrat_i18n.translate('added')).addClass('green_added');
//         }else{
//             show_alert(window.sokrat_i18n.translate('error'),msg.error);
//         }
//       }
//     });
// }