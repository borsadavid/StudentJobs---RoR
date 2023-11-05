class HomeController < ApplicationController
  #before_action :check admin!!!!!!

  def feed
    if user_signed_in?
  
      @jobs = if params[:title].present?
        Job.where("lower(title) LIKE ?", "%#{params[:title].downcase}%")
      else
        Job.all
      end.includes(:skills).sort_by do |job|
        matching_percentage(job)
      end.reverse

    else

      @jobs = if params[:title].present?
        Job.where("lower(title) LIKE ?", "%#{params[:title].downcase}%").order(created_at: :desc).includes(:skills)
      else
        Job.all.order(created_at: :desc).includes(:skills)
      end
      
    end
    
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js
    end
    
  end
  

  def view_job
    @job = Job.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

end