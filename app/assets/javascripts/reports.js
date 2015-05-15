$(document).on('ready page:load', function() { 
  var $projects_select_div = $('#projects-select-div');
  var $tasks_select_div = $('#tasks-select-div');

  // get most recent values of report variables
  function getDates() {
    var date = {};
    date.start = $("input[name='start_date']").val();
    date.end = $("input[name='end_date']").val();
    return date
  }

  // send AJAX post
  function sendAJAX( data ) {
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
  function getName(type_string) {
    var date = getDates();
    return_string = type_string + " report: " + date.start + " to " + date.end;
    return return_string
  }

  // get the task list for the select tag
  function getTaskSelect() {
    var project_id = $("#projects-select").val();
    $.ajax({
      type: 'get',
      url: 'reports',
      dataType: 'html',
      data: { project_id: project_id },
      success: function(data) { 
        $('#tasks-select-div').html( data );
      }
    });
  }

  // when a client is selected, send and AJAX call to get projects
  $('#client_name').change( function () {
    var client_id = $("#client_name").val();
    
    $.ajax({
      type: 'get',
      url: 'reports',
      dataType: 'html',
      data: { client_id: client_id },
      success: function(data) { 
        $projects_select_div.html( data );
        $tasks_select_div.html("");
        $('#projects-select').change( getTaskSelect )
      }
    });

  });

  // link to create a client report
  $('#client-link').click( function() {
    var date = getDates();
    var name = getName('Client');
    var client_id = $('#client_name').val();
    var data = {
      name: name,
      reportable_type: 'Client',
      reportable_id: client_id,
      start_date: date.start,
      end_date: date.end
    };
    if (client_id) {
      sendAJAX( data );
    }
  });

  // link to create a project report
  $('#project-link').click( function() {
    var date = getDates();
    var name = getName('Project');
    var project_id = $('#projects-select').val();
    var data = {
      name: name,
      reportable_type: 'Project',
      reportable_id: project_id,
      start_date: date.start,
      end_date: date.end
    };
    if (project_id) {
      sendAJAX( data );
    }

  }); 

  // link to create a user report
  $('#task-link').click( function() {
    var date = getDates();
    var name = getName('Task');
    var task_id = $('#tasks-select').val();
    var data = {
      name: name,
      reportable_type: 'Task',
      reportable_id: task_id,
      start_date: date.start,
      end_date: date.end
    };
    if (task_id) {
      sendAJAX( data );
    }

  }); 
  

});
