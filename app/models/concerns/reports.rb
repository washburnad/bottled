module Reports
  def self.task_events_html(task)
    output = "<li id='task#{task.id}'><input type='checkbox'"
    output += "ng-model='task#{task.id}' />#{task.name}"
    output += "<ul ng-show='task#{task.id}'>"
    task.events.each do |event|
      output += "<li id='event#{event.id}'>#{event.name}</li>"
    end
    output += "</ul></li>"
  end

  def self.project_tasks_html(project)
    output = "<li id='project#{project.id}'><input type='checkbox'"
    output += "ng-model='project#{project.id}' />#{project.name}"
    output += "<ul ng-show='project#{project.id}'>"
    project.tasks.each do |task|
      output += Reports.task_events_html(task)
    end
    output += "</ul></li>"
  end

  def self.client_projects_html(client)
    output = "<li id='client#{client.id}'><input type='checkbox'"
    output += "ng-model='client#{client.id}' />#{client.name}"
    output += "<ul ng-show='client#{client.id}'>"
    client.projects.each do |project|
      output += Reports.project_tasks_html(project)
    end
    output += "</ul></li>"
  end

  def self.user_clients_html(user)
    output = "<li id='user#{user.id}'><input type='checkbox'"
    output += "ng-model='user#{user.id}' />#{user.name}"
    output += "<ul ng-show='user#{user.id}'>"
    user.clients.each do |client|
      output += Reports.client_projects_html(client)
    end
    output += "</ul></li>"
  end
end
