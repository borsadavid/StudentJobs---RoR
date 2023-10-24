class Skill < ApplicationRecord
  has_many :cv_skills
  has_many :cvs, through: :cv_skills
  has_many :job_skills
  has_many :jobs, through: :job_skills
end
