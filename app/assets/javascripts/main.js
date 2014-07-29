$(document).ready(function(){
  $('.title').each(function(){
    $(this).click(function(){
      if($('.split').is(":visible") == false)
        $(".split").slideDown();
      var target = $(this).data("arrow");
      $('.arrow').animate({
          left: target
        }
        ,500
        ,function(){})
    });
  });
  
  $('.close').click(function(){
    $(".split").slideUp();
  });

});
