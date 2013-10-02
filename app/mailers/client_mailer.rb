class ClientMailer < ActionMailer::Base

  def notify_vehicle(vehicle, request)
    @request = request
    @vehicle = vehicle
    mail(to:'chris_mcnelis@yahoo.com', subject: "Testing email")
  end

end
