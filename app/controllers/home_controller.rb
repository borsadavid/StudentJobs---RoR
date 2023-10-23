class HomeController < ApplicationController
  #before_action :check admin!!!!!!

  def feed
    if user_signed_in?
      user_skills = return_user_skills
  
      @jobs = if params[:title].present?
        Job.where("title LIKE ?", "%#{params[:title]}%")
      else
        Job.all
      end.includes(:skills).sort_by do |job|
        matching_percentage(job)
      end.reverse
    else
      @jobs = if params[:title].present?
        Job.where("title LIKE ?", "%#{params[:title]}%").order(created_at: :desc)
      else
        Job.all.order(created_at: :desc)
      end
    end
  end

  def view_job
    @job = Job.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

end