class EntriesController < ApplicationController

  def index

    @clients = Client.all

    q = Entry.order(:done_at)

    if request[:client_id].present?
      q = q.joins(task: [{project: :client}])
      q = q.where("client_id = ?", request[:client_id])
    end

    if request[:project_id].present?
      q = q.joins(task: [{project: :client}])
      q = q.where("project_id = ?", request[:project_id])
    end

    if request[:task_id].present?
      q = q.where("task_id = ?", request[:task_id])
    end

    if request[:invoice_id].present?
      q = q.where("invoice_id = ?", request[:invoice_id])
    end

    # possibly filter by whether entry has been invoiced
    q = q.where("invoice_id IS NULL") if request[:invoiced] == 'yes'
    q = q.where("invoice_id IS NULL") if request[:invoiced] == 'no'

    # set date range if it exists
    q = q.where("done_at >= ?", request[:from]) if request[:from].present?
    q = q.where("done_at <= ?", request[:to]) if request[:to].present?

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
    params.require(:entry).permit(:task_id, :qty, :done_at, :rate)
  end

  def create

    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'success! new entry has been created' }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
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