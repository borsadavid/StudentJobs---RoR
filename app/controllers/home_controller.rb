class HomeController < ApplicationController
  #before_action :check admin!!!!!!

  def feed
    @locations = Location.all.order(city: :asc)
    
    @jobs = Job.includes(:skills).order(created_at: :desc)
    @jobs = @jobs.where("lower(title) LIKE ?", "%#{params[:title].downcase}%") if params[:title].present?

    if params[:filter_city].present?
      @jobs = @jobs.joins(:locations).where(locations: { city: params[:filter_city] })
    end

    if user_signed_in?
      @jobs = @jobs.sort_by { |job| -matching_percentage(job) }
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