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

  $('.next a').hover(function(){
      animateNext;
      nextInterval = setInterval(animateNext, 1050);
    },
    function(){
      clearInterval(nextInterval);
    });
  $('.previous a').hover(function(){
      animatePrevious;
      prevInterval = setInterval(animatePrevious, 1050);
    },
    function(){
      clearInterval(prevInterval);
    });
});

function animateNext(){
    $('.next a.next-arrow').css("background-position-y",100);
    $('.next a.next-arrow').animate({
      "background-position-y": 0
    },1000);
}

function animatePrevious(){
    $('.previous a.prev-arrow').css("background-position-y",0);
    $('.previous a.prev-arrow').animate({
      "background-position-y": 80
    },750);
}
