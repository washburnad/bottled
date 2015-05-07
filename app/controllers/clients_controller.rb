class ClientsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized, only: [ :show, :edit, :update]

	def index
		@clients = current_user.all_clients
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
		@client = Client.includes(:projects).find params[:id]
		@collaborators = @client.collaborators
		@projects = @client.projects
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client = Client.find(params[:id])
		@client.update_attributes(client_params)
		collaborator = Client.collaborating_user(collaboration_params)
		@client.add_collaborator(collaborator)

		if @client.valid?
			redirect_to client_path(@client)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	private

	def client_params
		params.require(:client).permit(:name, :contact_name, :contact_email, :contact_title, :contact_phone, :glyph_id, :glyph_color, :billing_rate)
	end

	def collaboration_params
		params.require(:collaboration).permit(:collaborator_string)
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
