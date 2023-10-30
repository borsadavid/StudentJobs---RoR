class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  has_one :user_information, dependent: :destroy
  has_one :company_information, dependent: :destroy
  has_many :cvs, dependent: :destroy
  has_many :jobs, dependent: :destroy


end
