class EntriesController < ApplicationController

  def index
    @entries = Entry.order(:done_at).all
  end

  def new
    @tasks = Task.all
    @entry = Entry.new
  end

  def createasdf
    @entry = Entry.find(params[:entry_id])
    @entry = @entry.entries.create(entry_params)
    redirect_to entry_path(@entry)
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
  def entry_params
    params.require(:entry).permit(:task_id, :name)
  end

end