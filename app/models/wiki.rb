class Wiki < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators, dependent: :destroy

  after_initialize { self.private ||= false }

  default_scope { order('title ASC') }
end
