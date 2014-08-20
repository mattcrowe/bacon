class TasksController < ApplicationController

    def index
      @tasks = Task.all
    end

    def new
        @projects = Project.all
        @task = Task.new
    end

    def createasdf
        @task = Task.find(params[:task_id])
        @task = @task.tasks.create(task_params)
        redirect_to task_path(@task)
    end

    def task_params
        params.require(:task).permit(:project_id, :name)
    end
    
    def create

        logger.debug { task_params.inspect }

        @task = Task.new(task_params)

        logger.debug { @task.inspect }

        if @task.save
            flash[:success] = "success! new task has been created"
            redirect_to @task
        else
            render 'new'
        end
    end

    def show
      @task = Task.find(params[:id])
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

    private
        def task_params
            params.require(:task).permit(:project_id, :name)
        end

end