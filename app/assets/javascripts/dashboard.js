//= require jquery-ui/sortable
//= require display_order

$(document).ready(function(){

  if($('#image_crop').length > 0)
  {
    $("#image_crop img").Jcrop({
      onSelect: markCrop,
      aspectRatio: 1 / 1
    })


    $("#image_crop button").bind('click',function(){
      minWidth = 400;//Replace with real value
      minHeight = 400;//Replace with real value
      width = $("#crop_w").attr('value');
      height = $("#crop_h").attr('value');
      if(width < minWidth || height < minHeight)
      {
        alert("Please select an area of at least "+minWidth+" by "+minHeight+" (w X h)");
        return false;
      }
    });

  }

});

function markCrop(img)
{
  $("#crop_x1").attr('value',img.x);
  $("#crop_y1").attr('value',img.y);
  $("#crop_x2").attr('value',img.x2);
  $("#crop_y2").attr('value',img.y2);
  $("#crop_w").attr('value',img.w);
  $("#crop_h").attr('value',img.h);
  $("#selection").text("Current Selection (w X h): "+img.w+" X "+img.h);
}
