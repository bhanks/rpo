$(document).ready(function(){
  $('.display-order').sortable().on('sortupdate', function(){
    var inputs = $('input.display-order');
    $.each(inputs, function(i){     
      $(inputs[i]).val(i);   
    });
  });
  var inputs = $('input.display-order');
  $.each(inputs, function(i){
    $(inputs[i]).val(i);     
  });
});
