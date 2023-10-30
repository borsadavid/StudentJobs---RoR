class CvSkill < ApplicationRecord
  belongs_to :cv, dependent: :destroy
  belongs_to :skill, dependent: :destroy
end
