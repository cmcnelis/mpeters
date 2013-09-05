class AgentsController < ApplicationController

    def new
        @agent = Agent.new
    end

    def create
        @agent = Agent.new(agent_params)
        if @agent.save
            falsh[:notice] = "Sucessfully registered."
            redirect_to root_url
        else
            render :action => 'new'
        end
    end

    private
        def agent_params
            params.require(:agent).permit!
        end
end
