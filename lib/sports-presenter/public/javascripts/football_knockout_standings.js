
$rrWidth = function() {
    $('.viewport-i .redright').each(function() {
     var getWidth = $('.viewport-i .teambox').width();
     var getWidth = getWidth + 34;
     $('.viewport-i .redright').css({'margin-left' : getWidth});
     var redWidth = getWidth / 5.2;
     $('.viewport-i .redright').css({'width' : redWidth});
  });
  
  $('.viewport-ii .redright').each(function() {
     var getWidth = $('.viewport-ii .teambox').width();
     var getWidth = getWidth + 34;
     $('.viewport-ii .redright').css({'margin-left' : getWidth-20});
     var redWidth = getWidth / 5.2;
     $('.viewport-ii .redright').css({'width' : redWidth});
  });
  
  $('.redleft').each(function() {
     var getWidth = $('.redright').width();
    $('.redleft').css({'margin-left' : -getWidth*1.5-7, 'width' : getWidth*1.5});
  });
}
$(window).resize(function() {   $rrWidth();  });
$(window).load(function() {   $rrWidth();  });

$(document).ready(function() {  
	$rrWidth();  
	var slider = new Swipe(document.getElementById('slider'), {
        callback: function(e, pos) {
          var i = bullets.length;
          while (i--) {
            bullets[i].className = ' ';
          }
          bullets[pos].className = 'on';
        }
  }),bullets = document.getElementById('position').getElementsByTagName('em');
});