class ClientsController < ApplicationController
	before_action :authenticate_user!

	def index

	end

	def new
		@client = Client.new
	end

	def create

	end

	def show

	end

	def edit

	end

	def update

	end

end
