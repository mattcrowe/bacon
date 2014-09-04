class ProjectsController < ApplicationController

  def index
    project = Project

    if request[:client_id].present?
      project = project.where("client_id = ?", request[:client_id])
    end

    @projects = project.all

    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @projects }
    end
  end

  def new
    @project = Project.new
  end

  def project_params
    params.require(:project).permit(:client_id, :name)
  end

  protect_from_forgery except: [:show]

  def create

    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'success! new project has been created' }
        format.js { }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
    @project = Project.find(params[:id])
    @task = Task.new
  end

  def edit
    # @clients = Client.all
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      flash[:success] = "success! project has been updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    flash[:success] = "success! project has been deleted"
    redirect_to projects_path
  end

end