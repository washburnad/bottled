$(document).on('ready page:load', function() { 
  var start_date, end_date;

  // get most recent values of report variables
  function updateVariables() {
    start_date = $("input[name='start_date']").val();
    end_date = $("input[name='end_date']").val();
  }

  // send AJAX post
  function sendAJAX( type, id, name ) {
    $.ajax({
        type: 'post',
        url: 'reports',
        dataType: 'json',
        data: {
          name: name,
          reportable_type: type,
          reportable_id: id,
          start_date: start_date,
          end_date: end_date
        },
        success: function(data) {
          console.log(data)
          console.log(data['redirect_url'])
          window.location.href = data['redirect_url'];
        }


    });

  }

  // return a string for a default report name
  function getName(type_string) {
    return_string = type_string+" report: "+start_date+" to "+end_date;
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
                $('#tasks-select-div').html( data );}
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
                $('#projects-select-div').html( data );
                $('#tasks-select-div').html("");
                $('#projects-select').change( getTaskSelect )
              }
          });

  });

  // link to create a client report
  $('#client-link').click( function() {
    updateVariables();
    var name = getName('Client');
    var client_id = $('#client_name').val();
    if (client_id) {
      sendAJAX( 'Client', client_id, name );
    }

  });

  // link to create a project report
  $('#project-link').click( function() {
    updateVariables();
    var name = getName('Project');
    var project_id = $('#projects-select').val();
    if (project_id) {
      sendAJAX( 'Project', project_id, name );
    }

  }); 

  // link to create a user report
  $('#task-link').click( function() {
    updateVariables();
    var name = getName('Task');
    var task_id = $('#tasks-select').val();
    if (task_id) {
      console.log('sendAJAX');
      sendAJAX( 'Task', task_id, name );
    }

  }); 
  

});
