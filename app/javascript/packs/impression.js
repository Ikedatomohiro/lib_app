$(document).on('turbolinks:load', function() {
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
            });
            $(this).removeClass('like');
            $('#like_' + impression_id).removeClass('already_like');
        } else {
            $.ajax({
                url:  "/likes",
                type: 'post',
                data: { impression_id: impression_id,
                        user_id: current_user_id,
                        authenticity_token: authenticity_token
                    }
            });
            $(this).addClass('like');
            $('#like_' + impression_id).addClass('already_like');
        }

    });

});
