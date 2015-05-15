module TasksHelper
  def show_task(task, include_glyph)
    display = include_glyph ? glyph_for(task.client) : ""
    display += link_to task.name, task_events_path(task)
  end
end
