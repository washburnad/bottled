module Reports
  def self.task_events_html(task)
    output = Reports.task_html(task)
    task.events.each do |event|
      output += Reports.event_html(event)
    end
    output += "</ul></li>"
  end

  def self.project_tasks_html(project)
    output = Reports.project_html(project)
    project.tasks.each do |task|
      output += Reports.task_events_html(task)
    end
    output += "</ul></li>"
  end

  def self.client_projects_html(client)
    output = Reports.client_html(client)
    client.projects.each do |project|
      output += Reports.project_tasks_html(project)
    end
    output += "</ul></li>"
  end

  def self.user_clients_html(user)
    output = "<li id='user#{user.id}' class='user'><input type='checkbox'"
    output += "ng-model='user#{user.id}' />#{user.name}"
    output += "<ul ng-show='user#{user.id}'>"
    user.clients.each do |client|
      output += Reports.client_projects_html(client)
    end
    output += "</ul></li>"
  end

  def self.event_html(event)
    output = "<li id='event#{event.id}' class='event'><span class='toggle-children'>&nbsp;</span>"
    output += "<span class='name'>&nbsp;#{event.name}</span><span class='description'>&nbsp;#{event.description}</span>"
    output += "<span class='duration'>&nbsp;#{event.duration}</span><span class='amount'>&nbsp;#{Reports.currency(event.amount_billable)}</span>"
    output += "</li>"
  end

  def self.task_html(task)
    output = "<li id='task#{task.id}' class='task'><span class='toggle-children'>"
    output += "<input type='checkbox' ng-model='task#{task.id}' /></span>"
    output += "<span class='name'>&nbsp;#{task.name}</span>"
    output += "<span class='description'>&nbsp;</span>"
    output += "<span class='duration'>&nbsp;</span>"
    output += "<span class='amount'>&nbsp;#{Reports.currency(100)}</span>"
    output += "</li><ul ng-show='task#{task.id}'>"
  end

  def self.project_html(project)
    output = "<li id='project#{project.id}' class='project'><span class='toggle-children'>"
    output += "<input type='checkbox' ng-model='project#{project.id}' /></span>"
    output += "<span class='name'>&nbsp;#{project.name}</span>"
    output += "<span class='description'>&nbsp;</span>"
    output += "<span class='duration'>&nbsp;</span>"
    output += "<span class='amount'>&nbsp;#{Reports.currency(100)}</span>"
    output += "</li><ul ng-show='project#{project.id}'>"
  end

  def self.client_html(client)
    output = "<li id='client#{client.id}' class='client'><span class='toggle-children'>"
    output += "<input type='checkbox' ng-model='client#{client.id}' /></span>"
    output += "<span class='name'>&nbsp;#{client.name}</span>"
    output += "<span class='description'>&nbsp;</span>"
    output += "<span class='duration'>&nbsp;</span>"
    output += "<span class='amount'>&nbsp;#{Reports.currency(100)}</span>"
    output += "</li><ul ng-show='client#{client.id}'>"
  end

  def self.currency(number)
    "$%.2f" % number
    
  end
end
