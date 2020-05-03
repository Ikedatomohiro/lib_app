$(document).on('turbolinks:load', function() {
    // 本を探すボタンの動作
    $('#search_book_button').click(function() {
        $('#search_book_button, #show_shelf_side_ico').hide();
        $('.search_book_button, .scan_book_button').fadeIn(500);
    });

    // 本棚を整理ボタンの操作
    // 本棚タイプの変更アイコンと本の削除や移動用のボタンを隠しておく
    $('#show_shelf_side_ico').click(function() {
        $('#show_shelf_side_ico').hide();
        $('.book_type_icon, .shelf_side_ico').fadeIn(500);
    });

    // 本を並べ替える。
    $('#books_in_shelf').sortable({
        scrollSpeed: 10,
        revert: 200,
        animation: 100,
        opacity: 0.8,
        handle: "p.handle",
        update: function(event, ui){
            var item = ui.item;
            var book_id = item.attr("id");
            var sort_url = "/books/"+ book_id +"/sort";
            var item_data = item.data();
            var params = { _mesthod: 'put' }
            params = {
              row_order_position: item.index(),
              authenticity_token: $("#authenticity_token_destroy").val()
            };
            $.ajax({
                url:      sort_url,
                type:     'put',
                dataType: 'json',
                data:     params
            });
        }
    });
    $('.shelf_modal').hide();
    $('.fire_work').click(function(){
        $('.shelf_modal').fadeOut(200);
        $(this).parent().children('.shelf_modal').fadeIn(500);
    });

















});

