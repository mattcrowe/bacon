class ProjectsController < ApplicationController

    def index
      @projects = Project.all
    end

    def create
        @client = Client.find(params[:client_id])
        @project = @client.projects.create(project_params)
        redirect_to client_path(@client)
    end

    def destroy
        @client = Client.find(params[:client_id])
        @project = @client.projects.find(params[:id])
        @project.destroy
        redirect_to client_path(@client)
    end

    private
        def project_params
            params.require(:project).permit(:name)
        end

end