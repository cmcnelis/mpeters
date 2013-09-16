class AgentsController < ApplicationController

    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:show, :edit, :update]

    def new
        @agent = Agent.new
    end

    def create
        @agent = Agent.new(agent_params)
        if @agent.save
            flash[:notice] = "Sucessfully registered."
            redirect_to root_url
        else
            render :action => 'new'
        end
    end

    def edit
        @agent = current_user
    end

    def update
        logger.debug("AgentsController::update")
        @agent = current_user
        if @agent.update(agent_params)
            flash[:notice]= "Sucessfully updated profile."
            redirect_to account_url
        else
            render :action=> 'edit'
        end
    end

    def show
        @agent = current_user
    end

    private
        def agent_params
            params.require(:agent).permit!
        end
end
