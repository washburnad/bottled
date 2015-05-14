module TasksHelper
  def show_task(task, include_glyph)
    display = include_glyph ? %Q( <span class='glyphicon' 
      style='color: #{task_client(task).glyph_color}'>
      #{task_client(task).glyph_id}</span> ) : ""
    display += link_to task.name, task_events_path(task)
  end
end
