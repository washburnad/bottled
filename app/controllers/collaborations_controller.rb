class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = current_user.clients
    @collaborations = current_user.collaborations
    puts "*"*36
    puts @collaborations
  end

  def new
    @client = Client.find(params[:client_id])
    puts @client
    @collaboration = @client.collaborations.new
  end

  def destroy
    Collaboration.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_collaborations_path(current_user)
  end

end
