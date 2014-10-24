class Api::V1::ClientsController < Api::V1::ApiController

  def index0
    @clients = Client.order(:name).all
    render json: @clients
  end

  def index
    client = Client

    if request[:name].present?
      client = client.where("name LIKE ?", "%#{request[:name]}%")
    end

    @clients = client.all

    render json: @clients
  end

  def show
    @client = Client.find(params[:id])
    render json: @client
  end

  def client_params
    params.require(:client).permit(:name, :contact, :email, :rate, :address1, :address2, :city, :state, :zip)
  end

  def create

    sleep 1

    @client = Client.new(client_params)

    if @client.save
      render json: @client
    else
      render false
    end
  end

  def update

    sleep 1

    @client = Client.find(params[:id])

    if @client.update(client_params)
      render json: @client
    else
      render false
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    render json: {}
  end

end