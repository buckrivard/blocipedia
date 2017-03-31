class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  enum role: [:member, :premium, :admin]

  after_initialize { self.role ||= :member}
  has_many :wikis
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki
end
