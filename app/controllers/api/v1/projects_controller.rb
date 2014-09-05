class Api::V1::ProjectsController < Api::V1::ApiController

  def index
    @projects = Project.order(:name).all
    render json: @projects
  end

end