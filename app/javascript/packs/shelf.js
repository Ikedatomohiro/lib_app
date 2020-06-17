$(document).on('turbolinks:load', function() {
    // 本棚名が表示されるところにスクロール
    var shelf_position = $('.shelf_marker').offset();
    $('.shelves_list').scrollLeft(shelf_position);
    // console.log(shelf_position.left);
window.onload = function () {
    var shelf_position = $('.shelf_marker').offset();
    $('.shelves_list').scrollLeft(shelf_position);
    // console.log(shelf_position.left);
};
    // 本を探すボタンの動作
    $('#search_book_button').click(function() {
        $('#shelf_buttons').hide();
        $('.search_button, .scan_book_button').fadeIn(500);
    });

    // 本棚を整理ボタンの操作
    // 本棚タイプの変更アイコンと本の削除や移動用のボタンを隠しておく
    $('#hide_shelf_arrange_ico').hide();
    $('#add_shelf').hide();
    $('.shelf_modify_buttons').hide();
    $('#show_shelf_arrange_ico').click(function() {
        $('#show_shelf_arrange_ico').hide();
        $('#search_book_button').hide();
        $('#hide_shelf_arrange_ico').fadeIn(500);
        $('.book_type_icon, .shelf_side_ico').fadeIn(500);
        $('#add_shelf').fadeIn(500);
        $('.shelf_modify_buttons').fadeIn(500);
        $('div.block_shelf_book_and_icon').addClass('book_handle'); // 本棚を整理ボタンをクリックしたときに本の画像をハンドルにする
        $('div.block_shelf_book_and_icon').addClass('flow_horizontal'); // 本棚を整理ボタンをクリックしたときに水平に揺れる
        $('p.thumbnail_block_shelf').addClass('flow_virtical'); // 本棚を整理ボタンをクリックしたときに水平に揺れる

    });
    $('#hide_shelf_arrange_ico').click(function() {
        $('#show_shelf_arrange_ico').fadeIn(500);
        $('#search_book_button').fadeIn(500);
        $('#hide_shelf_arrange_ico').hide();
        $('.book_type_icon, .shelf_side_ico').hide();
        $('#add_shelf').hide();
        $('.shelf_modify_buttons').hide();
        $('div.block_shelf_book_and_icon').removeClass('book_handle'); // 本棚を整理ボタンをクリックしたときに本の画像をハンドルにする
        $('div.block_shelf_book_and_icon').removeClass('flow_horizontal'); // 本棚を整理ボタンをクリックしたときに水平に揺れる
        $('p.thumbnail_block_shelf').removeClass('flow_virtical'); // 本棚を整理ボタンをクリックしたときに水平に揺れる
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
                    url: "/shelves/add_shelf",
                    type: 'post',
                    data: {
                        shelf_name: result.value,
                        authenticity_token: $("#authenticity_token").val()
                    }
                });
            }
        });
    });

    // 本を並べ替える。
    $('#books_in_shelf').sortable({
        scrollSpeed: 10,
        revert: 200,
        animation: 100,
        opacity: 0.6,
        tolerance: "pointer",
        handle: "div.book_handle, p.handle",
        update: function(event, ui) {
            var item = ui.item;
            var book_id = item.attr("value");
            var sort_url = "/books/" + book_id + "/sort";
            var item_data = item.data();
            var current_shelf_id = $('#current_shelf_id').val();
            var params = { _mesthod: 'put' }
            params = {
                row_order_position: item.index(),
                current_shelf_id: current_shelf_id,
                authenticity_token: $("#authenticity_token").val()
            };
            $.ajax({
                url: sort_url,
                type: 'put',
                dataType: 'json',
                data: params
            });
        }
    });

    // 本を違う本棚に移動する（ハンドルをドラッグアンドドロップ）
      var shelf_item = $(".shelf_label").droppable({
            hoverClass: "shelf_label_hover",
            accept: ".block_shelf_item",
            tolerance: "pointer",
            drop: function(event, ui) {
              // $('#books_in_shelf').sortable("cancel");
              var drop_flg = true;
                var shelf_id = $(this).val();
                var shelf_name = $(this).attr("name");
                var $book = ui.draggable
                var book_id = $book.attr("value");
                var book_title = $book.attr("name");
                var current_shelf_id = $('#current_shelf_id').val();
                var message = "「" + book_title + "」を「" + shelf_name + "」に移動したよ。";
                Swal.fire({
                    title: '',
                    text: message,
                    type: 'info',
                    timer: 2500,
                });
                $.ajax({
                    url: '/shelves/add_book',
                    type: 'post',
                    data: {
                        shelf_id: shelf_id,
                        book_id: book_id,
                        current_shelf_id: current_shelf_id,
                        authenticity_token: $("#authenticity_token").val()
                    }
                });
                if (current_shelf_id !== '0') {
                  $book.fadeOut('slow');
                }
            }
        });

    //  本棚を整理ボタンをクリックしたときに表示させるモーダルの動作
    $('.shelf_modal').hide();
    $('.fire_work').click(function() {
        $('.shelf_modal').fadeOut(200);
        $(this).parent().children('.shelf_modal').fadeIn(500);
    });

    // 本を削除するボタン
    $('.destroy_book').click(function() {
        var book_id = $(this).children('input').val();
        var destroy_url = "/books/" + book_id;
        var current_shelf_id = $('#current_shelf_id').val();
        if (current_shelf_id == 0) {
            var message = '本を削除すると感想も削除されるよ。';
        } else {
            var message = 'この本棚の本だけが削除されるよ。';
        }
        Swal.fire({
            title: '',
            text: message,
            type: 'question',
            showCancelButton: true,
            confirmButtonText: 'おっけー',
            cancelButtonText: 'やめる'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: destroy_url,
                    type: 'delete',
                    data: {
                        current_shelf_id: current_shelf_id,
                        authenticity_token: $("#authenticity_token").val()
                    }
                });
            }
        });
    });

    // 本を別の本棚に移動
    $('select').change(function() {
        var shelf_id = $(this).val();
        var book_id = $(this).nextAll('#book_id').val();
        var current_shelf_id = $('#current_shelf_id').val();
        var new_shelf_name = $(this).children('option').val(shelf_id);
        $.ajax({
            url: '/shelves/add_book',
            type: 'post',
            data: {
                shelf_id: shelf_id,
                book_id: book_id,
                current_shelf_id: current_shelf_id,
                authenticity_token: $("#authenticity_token").val()
            }
        });
        Swal.fire({
            title: '',
            text: "本を移動したよ",
            type: 'info',
            timer: 1000,
        });
        // モーダルを非表示にする
        $('.shelf_modal').fadeOut(500);
        // 移動した本の要素を非表示にする
        if (current_shelf_id != 0 && shelf_id != current_shelf_id) {
            $('#book_id_' + book_id).fadeOut(500);
        }
    });

    // 本棚の削除
    $('.destroy_shelf').click(function() {
        var shelf_id = $(this).children('input').val();
        var destroy_url = "shelves/" + shelf_id;
        var message = '本だなを削除するよ。';
        Swal.fire({
            title: '',
            text: message,
            type: 'question',
            showCancelButton: true,
            confirmButtonText: 'おっけー',
            cancelButtonText: 'やめる'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: shelf_id,
                    type: 'delete',
                    data: { authenticity_token: $("#authenticity_token").val() }
                });
                console.log(destroy_url);
            }
        });
    });

    // 本棚の並べ替え
    $('#shelves_list').sortable({
        scrollSpeed: 10,
        revert: 200,
        animation: 100,
        axis: 'x',
        opacity: 0.8,
        tolerance: "pointer",
        handle: ".handle, .handle2",
        update: function(event, ui) {
            var item = ui.item;
            var shelf_id = item.attr("value");
            var sort_url = "/shelves/" + shelf_id + "/sort";
            var item_data = item.data();
            var current_shelf_id = $('#current_shelf_id').val();
            var params = { _mesthod: 'put' }
            params = {
                row_order_position: item.index(),
                current_shelf_id: current_shelf_id,
                authenticity_token: $("#authenticity_token").val()
            };
            $.ajax({
                url: sort_url,
                type: 'put',
                dataType: 'json',
                data: params
            });
        }
    });





});