class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators

  default_scope { order('title ASC') }
end
