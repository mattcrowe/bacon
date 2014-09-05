class Api::ClientsController < Api::ApiController

  def index
    @clients = Client.order(:name).all
    render json: @clients
  end

  def show
    @client = Client.find(params[:id])
    render json: @client, :root => true
  end

  def client_params
    params.require(:client).permit(:name, :contact, :email, :rate, :address1, :address2, :city, :state, :zip)
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)
      render json: @client, :root => true
      # render json: 'id'=>@client.id
      # flash[:success] = "success! client has been updated"
      # redirect_to @client
    else
      # render 'edit'
      render false
    end
  end

end