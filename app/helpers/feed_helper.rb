module FeedHelper

  def matching_percentage(job)
    user_skills = return_user_skills
    job_skills = job.skills.pluck(:id)
    matching_skills = user_skills & job_skills
    if job_skills && user_skills
      percentage = (matching_skills.length.to_f / job_skills.length) * 100
    else
      percentage = 0
    end
  
    formatted_percentage = format("%.1f", percentage)
  end

  def return_user_skills
    if user_signed_in?
      current_user.cvs.map { |cv| cv.skills.pluck(:id) }.flatten.uniq
    end
  end

end
