class Reservation < ApplicationRecord
  has_many :tickets, inverse_of: :reservation
  belongs_to :event, optional: true

  include AASM

  aasm column: 'aasm_state', whiny_transitions: false do
    state :reserved, initial: true
    state :paid

    event :reserve do
      transitions from: :free, to: :reserved
    end

    event :pay do
      transitions from: :reserved, to: :paid
    end
  
  end
end
