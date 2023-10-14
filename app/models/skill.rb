class Skill < ApplicationRecord
  has_many :cv_skills
  has_many :cvs, through: :cv_skills
end
