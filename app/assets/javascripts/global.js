$(document).on("click", ".close", function() {
  $(this).parent('div').fadeOut('slow');
});

$(document).on('keyup','#search_options_container', function(){
  var search_keyword = $('#search_options_container').val();
  var search_keyword_trim = search_keyword.trim();
  if (search_keyword_trim.length == 0 ) {
    $('#search_options_container').val('');
    $('.result').text('');
    return;
  }
  search_items(search_keyword_trim);
});

function search_items(search_keyword){
  $.ajax({
    type :'get',
    data : {'search_keyword': search_keyword},
    url : "/user/search_user"
  });
}