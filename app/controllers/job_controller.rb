class JobController < ApplicationController
  before_action :check_company
  before_action :check_company_permission
  before_action :set_jobs

  def render_create
    @available_skills = Skill.all
    @new_job = Job.new
    respond_to do |f|
      f.js
    end
  end 
  
  def index 
    @available_skills = Skill.all
    @new_job = Job.new
  end

  def add_skills(job)
    current_user.jobs.find(job.id).skills.destroy_all

    selected_skill_ids = params[:job][:skill_ids]
    return unless selected_skill_ids.present?

    selected_skills = Skill.where(id: selected_skill_ids)
    job.skills << selected_skills
  end

  def create 
    @job = current_user.jobs.build(title: params[:job][:title], description: params[:job][:description])
    respond_to do |format|
      if @job.save
        add_skills(@job)
        format.json { render json: { message: "Job Posted!"} }
        format.js 
      else
        format.json { render json: { message: "Something went wrong"} }
      end
    end
  end

  def edit
    @available_skills = Skill.all
    @job = current_user.jobs.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

  def update
    @job = current_user.jobs.find(params[:id])
    if @job.update(title: params[:job][:title], description: params[:job][:description])
      add_skills(@job)
      respond_to do |format|
        format.json { render json: {message: "Job Posted!"} }
        format.js
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Something went wrong"} }
      end
    end
  end

  def destroy 
    @job = current_user.jobs.find_by(id: params[:id])
    respond_to do |format|
      if @job.destroy
        format.json { render json: {message: "Job deleted!"} }
        format.js
      else
        format.json { render json: {message: "Something went wrong"} }
      end
    end
  end


private

  def job_params
    params.require(:job).permit(:title, :description, :skill_ids[])
  end

  def set_jobs
    @jobs = current_user.jobs.all.order(created_at: :desc)
  end
end
