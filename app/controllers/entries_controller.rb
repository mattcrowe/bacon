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

    # set date range if it exists
    q = q.where("done_at >= ?", request[:from]) unless request[:from].blank?
    q = q.where("done_at <= ?", request[:to]) unless request[:to].blank?

    @entries = q.all

    # sum hours and rate*hours
    @hours = 0
    @total = 0
    @entries.each do |entry|
      @hours += entry.hours
      @total += entry.hours * entry.rate
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

    logger.debug { entry_params.inspect }

    @entry = Entry.new(entry_params)

    logger.debug { @entry.inspect }

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

  private

end