class Cv < ApplicationRecord
  belongs_to :user
  has_many :educations
  has_many :experiences
  has_many :cv_skills
  has_many :skills, through: :cv_skills
  has_many_attached :pdfs
  has_one_attached :picture
  has_many :applications
  has_many :jobs, through: :applications
end
