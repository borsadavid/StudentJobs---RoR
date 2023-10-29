class Job < ApplicationRecord
  belongs_to :user
  has_many :job_skills
  has_many :skills, through: :job_skills
  has_many :applications
  has_many :cvs, through: :applications
  
  before_destroy :clear_associated_skills
  
  private

  def clear_associated_skills
    self.skills.clear
  end
  
end
