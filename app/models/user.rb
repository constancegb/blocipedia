class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  before_save { self.email = email.downcase }
  before_save { self.role ||= :standard }

  # after_initialize :default
  #
  # def default
  #   self.role ||= :standard
  # end

  enum role: [:standard, :premium, :admin]

end
