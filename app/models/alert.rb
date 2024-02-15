class Alert < ApplicationRecord
    validates :market_id, presence: true
    validates :spread, presence: true, numericality: true
end
