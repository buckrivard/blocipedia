class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators, dependent: :delete_all

  after_initialize { self.private ||= false }

  default_scope { order('title ASC') }
end
