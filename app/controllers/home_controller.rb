class HomeController < ApplicationController
  #before_action :check_user_information

  def feed
    if user_signed_in?
      user_skills = current_user.cvs.map { |cv| cv.skills.pluck(:id) }.flatten.uniq
      @jobs = Job.all.includes(:skills).sort_by do |job|
        job_skills = job.skills.pluck(:id)
        matching_skills_count = (user_skills & job_skills).count
        -matching_skills_count 
      end
    else
      @jobs = Job.all.order(created_at: :desc)
    end
  end

  def view_job
    @job = Job.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

end