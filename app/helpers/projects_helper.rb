module ProjectsHelper
  def show_project(project, include_glyph)
    display = include_glyph ? glyph_for(project.client) : ""
    display += link_to project.name, client_project_path(project.client, project) 
  end
end
