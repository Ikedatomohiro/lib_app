$(document).on('turbolinks:load', function() {
    $('#publish_impression').click(function() {
        $.get({
            url: "#{user_publish_impression_path}",
            data: { publish_impression: $('#publish_impression_value').val() }
        });
    });
});

$(document).on('turbolinks:load', function() {
    $('#getBookInfo').click(function(e) {
        e.preventDefault();
        const isbn = $("#isbn").val();
        const url = "https://api.openbd.jp/v1/get?isbn=" + isbn;

        $.getJSON(url, function(data) {
            if (data[0] == null) {
                alert("データが見つかりません");
            } else {
                if (data[0].summary.cover == "") {
                    $("#thumbnail").html('<img src=\"\" />');
                } else {
                    $("#thumbnail").html('<img src=\"' + data[0].summary.cover + '\" style=\"border:solid 1px #000000\" />');
                }
                $("#title").val(data[0].summary.title);
                $("#publisher").val(data[0].summary.publisher);
                $("#volume").val(data[0].summary.volume);
                $("#series").val(data[0].summary.series);
                $("#author").val(data[0].summary.author);
                $("#pubdate").val(data[0].summary.pubdate);
                $("#cover").val(data[0].summary.cover);
                $("#description").val(data[0].onix.CollateralDetail.TextContent[0].Text);
            }
        });
    });
});