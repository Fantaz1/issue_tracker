class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates_presence_of :username
  validates_uniqueness_of :username
end
