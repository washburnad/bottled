
$(document).ready( function() {

	// initiate global variables
	var startElement = $('#start');
	var stopElement = $('#stop');
	var timeElement = $('#time');
	var elapsedTime = 0;

	// function to display current elapsed time, updated every 500ms
	function showTime(startTime) {
			// get current time in seconds
			var time = Math.floor(Date.now()/1000);
			elapsedTime = (time - startTime);
			
			// get hours, minutes, seconds and format them for display
			// and update HTML
			var h = Math.floor( elapsedTime/(60 * 60));
			timeCropped = elapsedTime - (h * 60 * 60);
			var m = Math.floor( (timeCropped)/(60));
			timeCropped -= (m * 60);
			var s = Math.floor( timeCropped );

			m = ( m < 10 ) ? '0' + m : m;
			s = ( s < 10 ) ? '0' + s : s;
			var timeString = h+':'+m+':'+s;
			timeElement.html(timeString);

			// set timer to repeat recursively
	    t = setTimeout(function () {
	        showTime(startTime)
	    }, 500);
	}


	// Initiate a timer event
	startElement.click(function( e ) {
		// display timer-box, hide startElement
		$('.timer-box').addClass('active');
		startElement.addClass('inactive');
		// get current time in s
		var startTime = Math.floor(Date.now()/1000);
		// initiate timer display
		showTime(startTime);
		// send post request to create event.  retrieve update url and assign it to the stopElement
	  $.ajax({
		          type: 'POST',
		          url: startElement.data('create-url'),
		          dataType: 'json',
		          data: { event: { start_time: startTime, name: (new Date().toJSON().slice(0,10) ) } },
		          success: function(data) { 
		          	stopElement.data('update-url', data.update_url);}
		        });
	});


	// End a timer event
	stopElement.click(function( e ) {
		//e.preventDefault()
		// get current time in s
		var endTime = Math.floor(Date.now()/1000);

		// send put request to update event attributes.  on success end timer and display start button
		$.ajax({
		          type: 'PUT',
		          url: stopElement.data('update-url'),
		          dataType: 'json',
		          data: { event: { end_time: endTime, duration: elapsedTime } },
		          success: function() {
		          	clearTimeout(t);
		          	startElement.removeClass('inactive');
		          }
		        });

	});

});