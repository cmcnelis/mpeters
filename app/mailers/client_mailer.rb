class ClientMailer < ActionMailer::Base

  def notify_vehicle(vehicle, request)
    @request = request
    @vehicle = vehicle
    mail(to: @vehicle.policy.email, subject: "Deductible Coverage")
  end

end
