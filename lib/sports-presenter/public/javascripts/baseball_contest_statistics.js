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