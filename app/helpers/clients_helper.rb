module ClientsHelper
  def show_client(client, include_glyph)
    display = include_glyph ? glyph_for(client) : ""
    display += link_to client.name, client_path(client) 
  end
end
