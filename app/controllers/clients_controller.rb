class ClientsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    #render plain: params[:client].inspect
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "success! new client has been created"
      redirect_to @client
    else
      render 'new'
    end
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

  private

  def client_params
    params.require(:client).permit(:name, :contact, :email, :rate)
  end

end