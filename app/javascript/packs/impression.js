
// サムネイルの画像が選択されたら送信ボタンを押す
$('#book_users_thumbnail').on('change', function () {
    $('#send_thumbnail').click();
    return false;
});

// 感想編集画面は非表示にする
$('.impression_text').hide();

// いいねのつけ外し
$('.heart').click(function(){
    var impression_id = $(this).children('input').val();
    var authenticity_token = $('input[name="authenticity_token').val();
    var current_user_id = $('#user_id').val();
    if ($(this).hasClass('like')) {
        var delete_url = "/likes/" + impression_id;
        $.ajax({
            url:  delete_url,
            type: 'delete',
            data: { impression_id: impression_id,
                    user_id: current_user_id,
                    authenticity_token: authenticity_token
                }
        })
        .then(
            $(this).removeClass('like'),
            $('#like_' + impression_id).removeClass('already_like')
            );
    } else {
        $.ajax({
            url:  "/likes",
            type: 'post',
            data: { impression_id: impression_id,
                    user_id: current_user_id,
                    authenticity_token: authenticity_token
                }
        })
        .then(
            $(this).addClass('like'),
            $('#like_' + impression_id).addClass('already_like')
        );
    }
});

// 感想をクリックすると編集モードに切り替わる
$('.impression_view').click(function() {
    $(this).hide();
    var impression_edit_area = $(this).next('.impression_text');
    impression_edit_area.fadeIn();
    var write_area = impression_edit_area.find('.impression_write_area');
    var height     = write_area[0].scrollHeight;

    write_area.css('height', height + 'px');

    // 文字数カウント
    var count_target = write_area.val();
    var result = 0;
    var tweet_content = '';
    var letter_count = 0;
    var remaining_letter = 0;
    for(var i=0;i<count_target.length;i++){
      var chr = count_target.charCodeAt(i);
      if((chr >= 0x00 && chr < 0x81) ||
         (chr === 0xf8f0) ||
         (chr >= 0xff61 && chr < 0xffa0) ||
         (chr >= 0xf8f1 && chr < 0xf8f4) ||
         (chr >= 0xD800 && chr <= 0xDBFF) || // サロゲートペア上位部分
         (chr >= 0xDC00 && chr <= 0xDFFF)    // サロゲートペア下位部分
         ){
        //半角文字の場合は1を加算
        result += 1;
      }else{
        //それ以外の文字の場合は2を加算
        result += 2;
      }
      if ((result <= 254) || (result == 255 && (chr >= 0xDC00 && chr <= 0xDFFF))) {
        // twitter投稿可能な分だけ別途保存用
        tweet_content = tweet_content + count_target[i];
      }
    }
    // 文字数アラートを表示
    letter_count = Math.ceil(result/2);
    remaining_letter = 128 - letter_count;
    // バイト数によって背景色を変える。
    if (result <= 214) {
        write_area.css('background-color', '#EAF8FF'); // 背景色水色
        write_area.parent().children('.letter_count_alart').text('　');
    } else if (result <= 255){
        write_area.css('background-color', '#EAF8FF'); // 背景色水色 
        write_area.parent().children('.letter_count_alart').text('あと' + remaining_letter + '文字までTwitterに投稿できるよ');
    } else {
        write_area.css('background-color', '#FCEAFF'); // 背景色ピンク色
        write_area.parent().children('.letter_count_alart').text('後半の一部は、Twitter投稿時に非表示になるよ');
    }
    // 保存用のフィールドにセット
    write_area.parent().children('input[name="tweet_content"]').val(tweet_content);

});

// 編集ボタンクリック時の動作
$('#edit_book_info').click(function(){
    $('#reading_start_date').children('span').hide();
    $('#reading_end_date').children('span').hide();
    $('#evaluation').hide();
    $('#reading_start_date').children('input[name="reading_start_date"]').fadeIn();
    $('#reading_end_date').children('input[name="reading_end_date"]').fadeIn();
    $('#evaluation_edit').fadeIn();
    $('#evaluation_edit').css('border', '2px solid #EAF8FF');
    $(this).hide();
    $('#finish_edit_book_info').show();

});


