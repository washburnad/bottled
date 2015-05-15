$(document).on('ready page:load', function() { 
  var $projects_select_div = $('#projects-select-div');
  var $projects_select = $('#projects-select');
  var $tasks_select_div = $('#tasks-select-div');
  var $tasks_select = $('#tasks-select');
  var $client_name = $('#client_name');

  // get most recent values of report variables
  function getDates() {
    var date = {};
    date.start = $("input[name='start_date']").val();
    date.end = $("input[name='end_date']").val();
    return date
  }

  // send AJAX post
  function sendReportAJAX( data ) {
    $.ajax({
      type: 'post',
      url: 'reports',
      dataType: 'json',
      data: data,
      success: function( data ) {
        window.location.href = data['redirect_url'];
      }
    });
  }

  // return a string for a default report name
  function getName(type_string, date) {
    return_string = type_string + " report: " + date.start + " to " + date.end;
    return return_string
  }

  // get the task list for the select tag
  function getTaskSelect() {
    var project_id = $projects_select.val();
    sendAJAXData( { project_id: project_id } , getTaskSelectSuccess );
  }

  // get the project list for the select tag
  function getProjectSelect() {
    var client_id = $client_name.val();
    sendAJAXData( { client_id: client_id } , getProjectSelectSuccess );
  }

  function sendAJAXData( data, success ) {
    $.ajax({
      type: 'get',
      url: 'reports',
      dataType: 'html',
      data: data,
      success: function(data) {
        success( data );
      }
    });  }

  function getTaskSelectSuccess( data ) {
    $tasks_select_div.html( data );
  }

  function getProjectSelectSuccess( data ) {
    $projects_select_div.html( data );
    $tasks_select_div.html("");
    $projects_select.change( getTaskSelect );
  }

  // when a client is selected, send an AJAX call to get projects
  $client_name.change( getProjectSelect );

  // link to create a client report
  $('#client-link').click( function() {
    var date = getDates();
    var name = getName('Client', date);
    var client_id = $client_name.val();
    var data = {
      name: name,
      reportable_type: 'Client',
      reportable_id: client_id,
      start_date: date.start,
      end_date: date.end
    };
    if (client_id) {
      sendReportAJAX( data );
    }
  });

  // link to create a project report
  $('#project-link').click( function() {
    var date = getDates();
    var name = getName('Project', date);
    var project_id = $projects_select.val();
    var data = {
      name: name,
      reportable_type: 'Project',
      reportable_id: project_id,
      start_date: date.start,
      end_date: date.end
    };
    if (project_id) {
      sendReportAJAX( data );
    }

  }); 

  // link to create a user report
  $('#task-link').click( function() {
    var date = getDates();
    var name = getName('Task', date);
    var task_id = $tasks_select.val();
    var data = {
      name: name,
      reportable_type: 'Task',
      reportable_id: task_id,
      start_date: date.start,
      end_date: date.end
    };
    if (task_id) {
      sendReportAJAX( data );
    }

  }); 
  

});
