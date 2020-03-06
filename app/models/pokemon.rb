class Pokemon < ApplicationRecord
  belongs_to :player, optional: true
end
