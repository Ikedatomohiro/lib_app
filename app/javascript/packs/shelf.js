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

    // 本棚を追加する
    $('#add_shelf').click(function() {
        Swal.fire({
          title: '',
          text: "追加する本棚の名前を入力してね。",
          // type: '',
          input: "text",
          showCancelButton: true,
          confirmButtonText: 'おっけー',
          cancelButtonText: 'やめる'
        }).then((result) => {
          if (result.value) {
            $.ajax({
                url:  "/shelves/add_shelf",
                type: 'post',
                data: { shelf_name: result.value,
                        authenticity_token: $("#authenticity_token").val() }
                });
          }
        });
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

    //  本棚を整理ボタンをクリックしたときに表示させる
    $('.shelf_modal').hide();
    $('.fire_work').click(function(){
        $('.shelf_modal').fadeOut(200);
        $(this).parent().children('.shelf_modal').fadeIn(500);
    });

    // 本を削除するボタン
    $('.destroy_book').click(function() {
        var book_id = $(this).val();
        var destroy_url = "books/" + book_id
        Swal.fire({
          title: '',
          text: "本を削除すると感想も削除されるよ。",
          type: 'question',
          showCancelButton: true,
          confirmButtonText: 'おっけー',
          cancelButtonText: 'やめる'
        }).then((result) => {
          if (result.value) {
            $.ajax({
                url:  destroy_url,
                type: 'delete',
                data: { authenticity_token: $("#authenticity_token").val() }
            });
          }
        });
    });

    $('.shelf_name').click(function() {
        var shelf_id = $(this).val();
        var shelf_show_url = '/shelves/' + shelf_id;
        $.ajax({
            url: shelf_show_url,
            type: 'get',
            data: {}
        });
    });














});

