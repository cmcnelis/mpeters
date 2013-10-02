class PoliciesController < ApplicationController

    before_filter :require_user

    def new
        @policy = Policy.new
        2.times {@policy.vehicles.build }
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

    def update
        @policy = Policy.find(params[:id])
        if @policy.update(policy_params)
            flash[:notice] = "Successfully updated policy  information."
            render :action=>'show'
        else
            render :action =>'edit'
        end
    end

    def destroy
        @policy = Policy.find(params[:id])
        if(@policy.destroy)
            flash[:notice] = "Successfully removed policy."
        end
        redirect_to account_url
    end

    private
        def policy_params
            params.require(:policy).permit(
                :number,  :first_name, :last_name, :email, :email_confirmation,
                :address, :city, :state, :zip_code, vehicles_attributes:
                [ :id, :vin, :make, :model, :color, :deductible, :previous_deductible])
        end
end
