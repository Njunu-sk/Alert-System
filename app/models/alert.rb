class Alert < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user

  validates :type, :title, presence: true
end
