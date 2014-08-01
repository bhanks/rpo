$(document).ready(function(){
  $('.featured').each(function(){
    $(this).click(function(){
      if($('.split').is(":visible") == false)
        $(".split").slideDown();
      var target = $(this).data("arrow");
      var shift = $(this).data("shift");
      $('.arrow').animate({
          left: target
        }
        ,500
        ,function(){});
      $('.details').animate({bottom:shift},500);
    });
  });
  
  $('.close').click(function(){
    $(".split").slideUp();
  });

});
