class Api::ProjectsController < Api::ApiController

  def index
    @projects = Project.order(:name).all
    render json: @projects
  end

end