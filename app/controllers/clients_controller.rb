class ClientsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized, only: [ :show, :edit, :update]

	def index
		@clients = current_user.clients.to_a
	end

	def new
		@client = Client.new
	end

	def create
		@client = current_user.clients.create(client_params)
		if @client.valid?
			redirect_to client_path(@client)
		else
			render :new, :status => :unprocessable_entity
		end		
	end

	def show
		@client = Client.find(params[:id])
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client = Client.find(params[:id])
		@client.update_attributes(client_params)
		if collaboration_params[:collaborating_user].present?
			user = User.find(collaboration_params[:collaborating_user])
			@client.add_collaborator(user)
		end

		if @client.valid?
			redirect_to client_path(@client)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	private

	def client_params
		params.require(:client).permit(:name, :contact_name, :contact_email, :contact_title, :contact_phone, :glyph_id, :glyph_color)
	end

	def collaboration_params
		params.require(:collaboration).permit(:collaborating_user)
	end

	helper_method :current_client
	def current_client
		@current_client ||= Client.find(params[:id])
	end


	def require_authorized
		if current_client.user != current_user
			redirect_to root_path, alert: 'Current user does not have access to that page.'
		end
	end

end
