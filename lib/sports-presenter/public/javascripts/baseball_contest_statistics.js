// Handles Jquery UI Logic.
// Document ready...
$(document).bind('pageinit');

$(document).live('pageinit', function(event)
{
	// Hide the home box score initially.
	$('.boxscore-batting-home').hide();
	$('.boxscore-pitching-home').hide();
	// Show away box score.
	$('#away_radio').click(function()
	{
		if (!$('.boxscore-batting-away').is(':visible'))
		{
			$('.boxscore-batting-away').fadeIn();
			$('.boxscore-pitching-away').fadeIn();
			$('.boxscore-batting-home').hide();
			$('.boxscore-pitching-home').hide();
		}else {
			$('.boxscore-batting-home').hide();
			$('.boxscore-pitching-home').hide();
		}
	});
	// Show home box score.
	$('#home_radio').click(function()
	{
		if (!$('.boxscore-batting-home').is(':visible'))
		{
			$('.boxscore-batting-home').fadeIn();
			$('.boxscore-pitching-home').fadeIn();
			$('.boxscore-batting-away').hide();
			$('.boxscore-pitching-away').hide();
		} else {
			$('.boxscore-batting-away').hide();
			$('.boxscore-pitching-away').hide();
		}
	});
});
$(document).ready( function(){
  //// SWIPE
	// The number of innings, (also the number of columns).
  var numInnings = $('div.innings table th').length;
  // If number of innings is <= 9 we're done. No need to swipe.
  if (numInnings <= 9)
    return;
  //pageNudge is used to calculate number of tables.
  var pageNudge = 0;
  if (numInnings.length % 9 == 0)
      {
        pageNudge = 0;
      }
      else
      {
        pageNudge = 1;
      }
  // The number of tables to split the current table into.
  var numberOfTables = Math.floor(pageNudge + numInnings / 9);
  if (numInnings % 9 < 3)
    numberOfTables--;
  for (var i = 0; i < numberOfTables; i++)
  {
    var firstIndex = i * 9;
    if (firstIndex < 0)
      firstIndex = 0;
    var lastIndex = firstIndex + 9;
    if (numInnings % 9 < 3 && i == numberOfTables - 1)
      lastIndex += numInnings % 9;
    if (lastIndex > numInnings)
    {
      lastIndex = numInnings;
    }
    var clonedTable = $('div.innings .standing').clone();
    clonedTable.find('thead').each(function(indexA)
    {
      $(this).find('th').each(function(indexB)
      {
        indexB += 1;
        if (indexB > lastIndex || indexB <= firstIndex)
        {
          $(this).remove();
        }
      });
    });
    clonedTable.find('tbody tr').each(function(indexA)
    {
      $(this).find('td').each(function(indexB)
      {
        indexB += 1;
        if (indexB > lastIndex || indexB <= firstIndex)
        {
          $(this).remove();
        }
      });
    });
    clonedTable.removeClass('standing');    
    $(clonedTable).insertBefore('div.innings .standing');
    if (i < numberOfTables - 1)
      $(clonedTable).wrap('<li style="display:none;" />');
    else
      $(clonedTable).wrap('<li style="display:block;"/>');
  }
  $('div.innings .standing').remove();
  $('.innings').wrapInner($('<div />').attr('id', 'slider'));
  $('#slider').wrapInner('<ul />');
  $('.innings table').addClass('standing');
  var slider = new Swipe(document.getElementById('slider'), {
    
  });
  slider.index = slider.length -1;
});