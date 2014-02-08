class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates_presence_of :name
  validates_uniqueness_of :name
end
