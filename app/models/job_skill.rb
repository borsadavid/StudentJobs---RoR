class JobSkill < ApplicationRecord
  belongs_to :job, dependent: :destroy
  belongs_to :skill, dependent: :destroy
end
