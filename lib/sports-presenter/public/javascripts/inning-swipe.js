// This code handles the case in which the number of innings goes over 9.
// The table is broken up into separate tables (in increments of 9)
// The proper elements are added around the tables to get swipe.js working.
// HOW SWIPE.JS WORKS:
// Briefly put, swipe.js looks for an element with an id of 'slider' and 
// then looks for an unordered list inside of the slider tag. Each <li> element
// within the <ul> acts as a page that can be swiped. Note: I tried
// various other nested elements to integrate swipe.js but without success.
// http://www.swipejs.com 


// TODO: This code assumes the score by inning for each team is included in
// its own table with the class of .standing-center. This means:
// We need to modify the haml to compensate for this by splitting the table
// contained in .linescore-container into 3 separate tables, standing-left, 
// standing-center, and standing-right. Left will contain the team names,
// center will contain the score by inning only (no empty cells), and left
// will contain the Runs Hits and Errors.

$(document).ready(function()
{
  // The number of innings, (also the number of columns).
  var numInnings = $('.standing-center th').length;
  // If number of innings is <= 9 we're done. No need to swipe.
  if (numInnings <= 9)
    return;
  //pageNudge is used to calculate number of tables.
  var pageNudge;
  if (numInnings.length % 9 == 0)
  {
    pageNudge = 0;
  }
  else
  {
    pageNudge = 1;
  }
  // The number of tables to split the current table into.
  var numberOfTables = Math.round(pageNudge + numInnings / 9);
  for (var i = 0; i < numberOfTables; i++)
  {
    var firstIndex = i * 9;
    if (firstIndex < 0)
      firstIndex = 0;
    var lastIndex = firstIndex + 9;
    if (lastIndex > numInnings)
    {
      lastIndex = numInnings;
    }
    var clonedTable = $('.standing-center').clone();
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
    clonedTable.removeClass('standing-center');
    $(clonedTable).insertBefore('.standing-center');
    $(clonedTable).wrap('<li />');
  }
  $('.standing-center').remove();
  $('.inning-container').removeClass('inning-container').attr('id', 'slider');
  $('#slider').wrapInner('<ul />');
  var slider = new Swipe(document.getElementById('slider'), {
    
  });
});