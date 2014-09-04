class ClientsController < ApplicationController

  def index
    @clients = Client.order(:name).all
  end

  def new
    @client = Client.new
  end

  def client_params
    params.require(:client).permit(:name, :contact, :email, :rate, :address1, :address2, :city, :state, :zip)
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "success! new client has been created"
      redirect_to @client
    else
      render 'new'
    end
  end

  def show
    @client = Client.find(params[:id])
    @project = Project.new
    @payment = Payment.new
  end

  def json
    @client = Client.find(params[:id])
    @project = Project.new
    @payment = Payment.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)
      flash[:success] = "success! client has been updated"
      redirect_to @client
    else
      render 'edit'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    flash[:success] = "success! client has been deleted"
    redirect_to clients_path
  end

end