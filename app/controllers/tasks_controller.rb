class TasksController < ApplicationController

  def index

    task = Task

    if request[:project_id].present?
      task = task.where("project_id = ?", request[:project_id])
    elsif request[:client_id].present?
      task = task.joins(project: :client).where("client_id = ?", request[:client_id])
    end

    @tasks = task.all
  end

  def new
    @projects = Project.all
    @task = Task.new
  end

  def task_params
    params.require(:task).permit(:project_id, :name)
  end

  def create

    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'success! new task has been created' }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @task = Task.find(params[:id])
    @entry = Entry.new
  end

  def edit
    @projects = Project.all
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = "success! task has been updated"
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = "success! task has been deleted"
    redirect_to tasks_path
  end

end