class Alert < ApplicationRecord
  self.inheritance_column = :_type_disabled

  validates :type, :title, presence: true
end
