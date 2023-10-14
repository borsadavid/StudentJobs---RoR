class CvController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cv, only: [:create_education, :create_experience, :add_skills]

  def index
    @cv = current_user.cvs.all
    @new_cv = Cv.new
  end

  def new
    @new_cv = Cv.new
  end

  def create
    user = User.find(current_user.id)
    @cv = user.cvs.create(cv_params)
    if @cv.save
      redirect_to configure_cv_cv_path(@cv.id)
    else
      flash[:error] = "Something went wrong!"
      redirect_to landing_path
    end
  end

  def configure_cv
    @available_skills = Skill.all
    @cv = Cv.find(params[:id])
    @education = Education.new
    @experience = Experience.new
    @skill = Skill.new
  end

  def create_education
    @education = @cv.educations.create(education_params)
    if !@education.save
      flash[:error] = "Something went wrong! Education"
      return
    else
      flash[:success] = "Education added."
      return
    end
  end

  def update_education
    @cv = Cv.find(params[:cv_id])
    education = @cv.educations.find(params[:id])
  
    if education.update(education_params)
      flash[:success] = "Education updated."
      return
    else
      flash[:error] = "Failed to update education."
      return
    end
  end

  def create_experience
    @experience = @cv.experiences.create(experience_params)
    if !@experience.save
      flash[:error] = "Something went wrong! Experience"
      return
    else
      flash[:success] = "Experience added."
      return
    end
  end

  def update_experience
    @cv = Cv.find(params[:cv_id])
    experience = @cv.experiences.find(params[:id])
  
    if experience.update(experience_params)
      flash[:success] = "Experience updated."
      return
    else
      flash[:error] = "Failed to update experience."
      return
    end
  end

  def add_skills
    selected_skill_ids = skills_params[:skill_ids]
  
    if selected_skill_ids.present?
      selected_skills = Skill.where(id: selected_skill_ids)
      @cv.skills << selected_skills
  
      if @cv.save
        flash[:success] = "Skills added."
      else
        flash[:error] = "Failed to add skills."
      end
    else
      flash[:error] = "No skills selected."
    end
  
    redirect_to landing_path
  end

private

  def set_cv
    @cv = Cv.find(params[:cv_id])
  end

  def cv_params
    params.require(:cv).permit(:title)
  end

  def education_params
    params.require(:education).permit(:institution, :specialization, :degree, :started_at, :finished_at, :ongoing)
  end

  def experience_params
    params.require(:experience).permit(:title, :employer, :description, :started_at, :finished_at, :ongoing)
  end

  def skills_params
    params.require(:cv).permit(skill_ids: [])
  end

end
