//= require jquery
//= require rails-ujs
//= require activestorage
//= requrie bootstrap-sprockets
//= require jquery.flexslider
//= requrie typeahead.bundle
//= require_tree .
//= require_self

var remove = function(id) {
  console.log(id);
  document.getElementById(id).style.display = 'none';
};

// var suggestedData = new Bloodhound({
//   datumTokenizer: Bloodhound.tokenizers.obj.whitespace,
//   queryTokenizer: Bloodhound.tokenizers.whitespace,
//   remote: {
//     url: '/products/autocomplete?query=%QUERY',
//     wildcard: '%QUERY'
//   }
// });

// $('#product-search').typeahead(null, {
//   source: suggestedData
// });

$(document).ready(function(){ 
  $('.flexslider').flexslider({
    nextText: "XXX"
  });
});