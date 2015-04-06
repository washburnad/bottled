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

  def create
    @client = Client.find(params[:client_id])
    @collaboration = @client.collaborations.create(collaboration_params)
    if @collaboration.valid?
      redirect_to user_collaborations_path(current_user)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :client_id)
  end
end
