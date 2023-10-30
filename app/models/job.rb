class Job < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :applications, dependent: :destroy
  has_many :cvs, through: :applications
  
end
