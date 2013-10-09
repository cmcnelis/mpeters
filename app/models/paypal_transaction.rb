class PaypalTransaction < ActiveRecord::Base

 ACTIVE = "Active"
 PENDING = "Pending"
 CLOSED = "Closed"

  validates_presence_of :amount
  validates_presence_of :pp_id
  validates_presence_of :approved
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :card_number
  validates_presence_of :card_type
  validates_presence_of :exp
  validates_presence_of :status, :inclusion=> { in: %w(ACTIVE PENDING CLOSED),
    message: "%{value} is not a valid status."}

  belongs_to :policy
end
