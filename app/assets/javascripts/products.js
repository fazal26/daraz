$(document).ready(function() {
  $.ajax({
    type: 'GET',
    dataType: "json",
    url: '/products',
    success: function(data) {
      $('#autocomplete').autocomplete({
        source: data.titles
      });
    },
    error: function(error) {
      //show flash message for error
    }
  });
});

  