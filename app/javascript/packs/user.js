  $(function() {
    $('#publish_impression').click(function() {
      $.get({
        url: "#{user_publish_impression_path}",
        data: { publish_impression: $('#publish_impression_value').val() }
      });
    });
  });