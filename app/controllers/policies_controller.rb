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
            # This is where it gets wierd. We need to send out and email
            # if  we have vehicles since the policy doesn't contain any information
            # to build a payment transaction off of.
            # It is not mandatory to add at least one vehicle during registration, but I
            # think it probably should be.
            unless @policy.vehicles.nil? || @policy.vehicles.count == 0
                logger.debug 'PoliciesController::Got some vehicles, sending out an email.'
                ClientMailer.notify_policy(@policy, request).deliver
            end
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

    def pay
        logger.debug("Pay<< params = #{params.inspect}")
        @vehicle = Vehicle.find(params[:id])
        @payment_info = PaymentInfo.new
        logger.debug("Pay >> vehicle = #{@vehicle.inspect}")
    end

    def transaction
        logger.debug('Yup we are paying now!!!')
        logger.debug("Params >> #{params.inspect}")
        @vehicle = Vehicle.find(params[:id])
        @payment_info = PaymentInfo.new(params[:payment_info])
        if @payment_info.valid?
            logger.debug("Pooo")
            @paypal = PayPalHelper.new(@payment_info, @vehicle)
            @paypal.make_payment
            redirect_to root_path
        else
            render :action=>'pay'
        end
    end

    def notify
        logger.debug "VehicleController>>notify <<<"
        @vehicle = Vehicle.find(params[:id])
        mail = ClientMailer.notify_vehicle(@vehicle, request).deliver
        logger.debug "sent mail #{mail.inspect}"
        flash[:notice] = "Sent an email reminder to the policy holder."
        redirect_to account_policy_vehicle_path(params[:policy_id], params[:id])
    end

    private
        def policy_params
            params.require(:policy).permit(
                :number,  :first_name, :last_name, :email, :email_confirmation,
                :address, :city, :state, :zip_code, vehicles_attributes:
                [ :id, :vin, :make, :model, :color, :deductible, :previous_deductible, :year, :drivers])
        end
end
