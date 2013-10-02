class ClientMailer < ActionMailer::Base

  def notify_vehicle(vehicle)
    @vehicle = vehicle
    mail(to:'steph_mcnelis@yahoo.com', subject: "Testing email")
  end

end
