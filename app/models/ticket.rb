class Ticket < ApplicationRecord
  belongs_to :reservation, optional: true
end
