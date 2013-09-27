require 'pay_pal_helper'
require_dependency 'payment_info'

class VehiclesController < ApplicationController

    before_filter :require_user, :except=>[:pay, :transaction]

    LOGGER_TAG ="VehiclesController::"

    def new
        @vehicle = Vehicle.new
    end

    def create
        @policy = Policy.find(params[:policy_id])
        @vehicle = @policy.vehicles.build(vehicle_params)
        logger.debug("VehiclesController::create #{@policy.inspect}")
        logger.debug("VehiclesController::create #{@vehicle.inspect}")

        if @vehicle.save
            flash[:notice] = "Successfully added a new vechicle."
            redirect_to account_policy_path(params[:policy_id])
        else
            render :action=> 'new'
        end
    end

    def show
        @vehicle = Vehicle.find(params[:id])
    end

    def edit
        @vehicle = Vehicle.find(params[:id])
    end

    def update
        logger.debug("#{LOGGER_TAG} update")
        @vehicle = Vehicle.find(params[:id])
        if @vehicle.update(vehicle_params)
            flash[:notice] = "Sucessfully updated vehicle information."
            render :action => 'show'
        else
            render :action => 'edit'
        end
    end

    def destroy
        @vehicle = Vehicle.find(params[:id])
        if @vehicle.destroy
            flash[:notice] = "Successfully removed vehicle."
        end

        redirect_to account_policy_path(params[:policy_id])
    end

    def pay
        @vehicle = Vehicle.find(params[:id])
        @payment_info = PaymentInfo.new
    end

    def transaction
        logger.debug('Yup we are paying now!!!')
        logger.debug("Params >> #{params.inspect}")
        @payinfo = PaymentInfo.new(params[:payment_info])
        #@paypal.make_payment
        redirect_to pay_path
    end

    private
        def vehicle_params
            params.require(:vehicle).permit(:vin,
                :make,
                :model,
                :color,
                :deductible,
                :previous_deductible,
                :drivers)
        end
end
