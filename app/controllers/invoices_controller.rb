class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.order(:ends_at).all
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def invoice_params
    params.require(:invoice).permit(:client_id, :name)
  end

  def create

    logger.debug { invoice_params.inspect }

    @invoice = Invoice.new(invoice_params)

    logger.debug { @invoice.inspect }

    if @invoice.save
      flash[:success] = "success! new invoice has been created"
      redirect_to @invoice
    else
      render 'new'
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @clients = Client.all
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(invoice_params)
      flash[:success] = "success! invoice has been updated"
      redirect_to @invoice
    else
      render 'edit'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    flash[:success] = "success! invoice has been deleted"
    redirect_to invoices_path
  end

end