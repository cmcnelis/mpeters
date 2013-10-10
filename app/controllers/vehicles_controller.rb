require 'pay_pal_helper'
require_dependency 'payment_info'

class VehiclesController < ApplicationController

    before_filter :require_user, :except=>[:pay, :transaction]

    LOGGER_TAG ="VehiclesController::"

    def new
        @vehicle = Vehicle.new
    end

    def create
        logger.debug("#{LOGGER_TAG}create >> #{params.inspect}")
        @policy = Policy.find(params[:policy_id])
        @vehicle = @policy.vehicles.build(vehicle_params)
        # This is where we could check to make sure we get at least
        # one vehicle defined.
        logger.debug("#{LOGGER_TAG}create #{@policy.inspect}")
        logger.debug("#{LOGGER_TAG}reate #{@vehicle.inspect}")

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
        logger.debug "#{LOGGER_TAG}destroy"
        @vehicle = Vehicle.find(params[:id])
        if @vehicle.destroy
            flash[:notice] = "Successfully removed vehicle."
        end

        redirect_to account_policy_path(params[:policy_id])
    end

    private
        def vehicle_params
            params.require(:vehicle).permit(:vin,
                :make,
                :model,
                :color,
                :deductible,
                :previous_deductible,
                :drivers,
                :year)
        end
end
