class PoliciesController < ApplicationController

    before_filter :require_user

    def new
        @policy = Policy.new
    end

    def create
        @agent = current_user
        @policy = @agent.policies.build(policy_params)
        if @policy.save
            flash[:notice] = "Sucessfully created new policy."
            redirect_to account_url
        else
            render :action => 'new'
        end
    end

    def edit
        @policy = Policy.find(params[:id])
    end

    def show
        @policy = Policy.find(params[:id])
    end

    private
        def policy_params
            params.require(:policy).permit!
        end
end
