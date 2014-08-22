class EntriesController < ApplicationController

  def index

    @clients = Client.all

    q = Entry.order(:done_at)

    unless request[:client_id].blank?
      q = q.joins(task: [{project: :client}])
      q = q.where("client_id = ?", request[:client_id])
    end

    if request.GET.include? "project_id"
      q = q.joins(task: [{project: :client}])
      q = q.where("project_id = ?", request[:project_id])
    end

    q = q.where("task_id = ?", request[:task_id]) unless request[:task_id].blank?
    q = q.where("invoice_id = ?", request[:invoice_id]) unless request[:invoice_id].blank?


    q = q.where("invoice_id IS NULL") if request[:invoiced] == 'no'
    q = q.where("invoice_id IS NOT NULL") if request[:invoiced] == 'yes'

    # set date range if it exists
    q = q.where("done_at >= ?", request[:from]) unless request[:from].blank?
    q = q.where("done_at <= ?", request[:to]) unless request[:to].blank?

    @entries = q.all

    # sum qty and rate*qty
    @qty = 0
    @total = 0
    @entries.each do |entry|
      @qty += entry.qty
      @total += entry.qty * entry.rate
    end

  end

  def new
    @tasks = Task.all
    @entry = Entry.new
  end

  def entry_params
    params.require(:entry).permit(:task_id, :name)
  end

  def create

    @entry = Entry.new(entry_params)

    if @entry.save
      flash[:success] = "success! new entry has been created"
      redirect_to @entry
    else
      render 'new'
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @tasks = Task.all
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update(entry_params)
      flash[:success] = "success! entry has been updated"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    flash[:success] = "success! entry has been deleted"
    redirect_to entries_path
  end

  def invoice

    # d request[:entry].to_a.first.pop
    # d request[:entry].to_a.last.pop

    #first entry in batch
    entry_1 = Entry.find(request[:entry].to_a.first.pop)
    #last entry in batch
    entry_n = Entry.find(request[:entry].to_a.last.pop)

    # request.POST[:entry].each do |entryID|
    #   d entryID
    #   d entryID.pop
    # end

    invoice = Invoice.create(
        client_id: request[:client_id],
        starts_at: entry_1.done_at,
        ends_at: entry_n.done_at,
    )

    total = 0
    request.POST[:entry].each do |entry_id|
      entry = Entry.find(entry_id.pop)
      entry.invoice = invoice
      entry.save
      total += entry.qty * entry.rate
    end

    invoice.total = total
    invoice.save

    flash[:success] = "success! new invoice has been created"
    redirect_to invoice_path(invoice)
  end

  private

end