
$(document).on('ready page:load', function() {
	// initiate global variables
	var pauseElement = $('#pause');
	var startElement = $('#start');
	var stopElement = $('#stop');
	var timeElement = $('#time');
	var timerBox = $('.timer-box');
	var elapsedTime = 0;
	var pausedTime = 0;
	var pauseStart, pauseEnd;


	// function to display current elapsed time, updated every 500ms
	function showTime(startTime) {
			// get current time in seconds
			var time = Math.floor(Date.now()/1000);
			if (!timerBox.hasClass('paused')) {
				elapsedTime = (time - startTime - pausedTime);
			};
			console.log( pausedTime, ' ', elapsedTime);
			
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


	pauseElement.click(function(e) {
		if (timerBox.hasClass('running')) {
			timerBox.addClass('paused').removeClass('running');
			pauseStart = Math.floor(Date.now()/1000);
			console.log('start pause at', pauseStart)
			
		} else if (timerBox.hasClass('paused')) {
			timerBox.addClass('running').removeClass('paused');
			pauseEnd = Math.floor(Date.now()/1000);
			console.log('end pause at ',pauseEnd);
			pausedTime = pausedTime + pauseEnd - pauseStart;
			console.log('total paused time is ',pausedTime);
		}
		

	});

	// Initiate a timer event
	startElement.click(function( e ) {
		// display timer-box, hide startElement
		timerBox.removeClass('puased').addClass('running');
		startElement.addClass('inactive');
		// get current time in s
		now = new Date;
		var startTime = Math.floor(now /1000);
		// initiate timer display
		showTime(startTime);
		startTimeUTC = (now).toUTCString();

		// send post request to create event.  retrieve update url and assign it to the stopElement
	  $.ajax({
		          type: 'POST',
		          url: startElement.data('create-url'),
		          dataType: 'json',
		          data: { event: { start_time: startTimeUTC } },
		          success: function(data) { 
		          	stopElement.data('update-url', data.update_url);}
		        });
	});


	// End a timer event
	stopElement.click(function( e ) {
		timerBox.removeClass('running').removeClass('paused');
		// get current time in s
		var endTime = Math.floor(Date.now()/1000);
		// get name of event from input
		eventName = document.getElementById('name').value

		// send put request to update event attributes.  on success end timer and display start button

		$.ajax({
		          type: 'PUT',
		          url: stopElement.data('update-url'),
		          dataType: 'json',
		          data: { event: { duration: elapsedTime/60, name: eventName } },
		          success: function() {
		          	clearTimeout(t);
		          	startElement.removeClass('inactive');
		          }
		        });

	});

});