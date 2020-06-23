$(document).on('turbolinks:load', function() {
    // いいねボタン
    $('.heart').click(function(){
        $(this).toggleClass('like');
    });

});
