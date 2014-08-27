class InvoicesController < ApplicationController

  def index

    invoice = Invoice

    if request[:client_id].present?
      invoice = invoice.where("client_id = ?", request[:client_id])
    end

    if request[:project_id].present?
      invoice = invoice.joins(client: :projects).where("projects.id = ?", request[:project_id])
    end

    if request[:task_id].present?
      invoice = invoice.joins(:entries).where("entries.task_id = ?", request[:task_id])
    end

    @invoices = invoice.all
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def invoice_params
    params.require(:invoice).permit(:client_id, :total, :starts_at, :ends_at, :paid)
  end

  def create

    @invoice = Invoice.new(invoice_params)

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

  def compose
    @invoice = Invoice.find(params[:id])
    @invoice.genpdf
  end

  def notify

    @invoice = Invoice.find(params[:id])

    InvoiceMailer.invoice_email(@invoice, request[:email], request[:subject], request[:body]).deliver

    flash[:success] = "success! invoice has been sent"
    redirect_to invoice_path(params[:id])

  end

end