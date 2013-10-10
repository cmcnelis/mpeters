class ClientMailer < ActionMailer::Base

  def notify_vehicle(vehicle, request)
    @request = request
    @vehicle = vehicle
    mail(to: @vehicle.policy.email, subject: "Deductible Coverage")
  end

  def notify_policy(policy, request)
    logger.debug "ClientMailer::notify_policy<<< .. policy = #{policy.inspect}"
    @policy = policy
    @request = request
    mail(:to=>@policy.email, :subject=>'New Policy Created For You')
  end
end
