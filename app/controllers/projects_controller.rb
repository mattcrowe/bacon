class ProjectsController < ApplicationController

  def index
    q = Project

    q = q.where("client_id = ?", request[:client_id]) if request.GET.include? "client_id"

    @projects = q.all
  end

  def new
    @clients = Client.all
    @project = Project.new
  end

  def project_params
    params.require(:project).permit(:client_id, :name)
  end

  def create

    @project = Project.new(project_params)

    if @project.save
      flash[:success] = "success! new project has been created"
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @clients = Client.all
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

  private
  # def project_params
  #     params.require(:project).permit(:client_id, :name)
  # end

end