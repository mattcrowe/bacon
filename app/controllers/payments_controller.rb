class PaymentsController < ApplicationController

  def index
    payment = Payment

    if request[:client_id].present?
      payment = payment.where("client_id = ?", request[:client_id])
    end

    @payments = payment.all
  end

  def new
    @clients = Client.all
    @payment = Payment.new
  end

  def payment_params
    params.require(:payment).permit(:client_id, :total, :paid_at)
  end

  def create

    @payment = Payment.new(payment_params)

    if @payment.save
      flash[:success] = "success! new payment has been created"
      redirect_to @payment
    else
      render 'new'
    end
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def edit
    @clients = Client.all
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])

    if @payment.update(payment_params)
      flash[:success] = "success! payment has been updated"
      redirect_to @payment
    else
      render 'edit'
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    flash[:success] = "success! payment has been deleted"
    redirect_to payments_path
  end

  private
  # def payment_params
  #     params.require(:payment).permit(:client_id, :name)
  # end

end