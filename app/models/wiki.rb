class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators, dependent: :destroy

  after_initialize { self.private ||= false }

  default_scope { order('title ASC') }
end
