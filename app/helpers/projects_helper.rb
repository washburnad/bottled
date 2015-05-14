module ProjectsHelper
  def show_project(project, include_glyph)
    display = include_glyph ? %Q( <span class='glyphicon' 
      style='color: #{project_client(project).glyph_color}'>
      #{project_client(project).glyph_id}</span> ) : ""
    display += link_to project.name, client_project_path(project_client(project), project) 
  end
end
