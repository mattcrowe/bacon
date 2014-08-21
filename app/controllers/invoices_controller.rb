class InvoicesController < ApplicationController

  def index
    q = Invoice
    q = q.where("client_id = ?", request[:client_id]) if request.GET.include? "client_id"
    if request.GET.include? "project_id"
      q = q.joins(client: :projects).where("projects.id = ?", request[:project_id])
    end
    q = q.joins(:entries).where("entries.task_id = ?", request[:task_id]) if request.GET.include? "task_id"

    @invoices = q.all
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def invoice_params
    params.require(:invoice).permit(:client_id, :name)
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

    # require 'net/smtp'
    # msg = "Subject: Hi There!\n\ntest 4 This works, and this part is in the body."
    # smtp = Net::SMTP.new 'smtp.gmail.com', 587
    # smtp.enable_starttls
    # smtp.start('gmail.com', 'matthew.p.crowe@gmail.com', 'tosaotpsixglbhso', :login) do
    #   smtp.send_message(msg, 'matthew.p.crowe@gmail.com', '"Matt Crowe" <matt@zym.me>')
    # end

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
  end

  def notify

    require 'net/smtp'
    msg = "Subject: %s\n\n%s" % [request[:subject],request[:body]]
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', 'matthew.p.crowe@gmail.com', 'tosaotpsixglbhso', :login) do
      smtp.send_message(msg, 'matthew.p.crowe@gmail.com', request[:email])
    end

    flash[:success] = "success! invoice has been sent"
    redirect_to invoice_path(9)

  end

end