class CvController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cv, except: [:index, :new, :create, :configure_cv]

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
    @index = 0
    @available_skills = Skill.all
    @cv = Cv.find(params[:id])
    @education = Education.new
    @experience = Experience.new
    @skill = Skill.new
  end

  def create_education
    @education = @cv.educations.create(education_params)
    if !@education.save
      flash[:error] = "Something went wrong!"
      redirect_to configure_cv_cv_path(@cv)
    else
      flash[:success] = "Added succesfully!"
      redirect_to configure_cv_cv_path(@cv)
    end
  end

  def update_education
    education = @cv.educations.find(params[:id])
  
    if education.update(education_params)
      render json: { message: "Education updated." }
    else
      render json: { message: "Failed to update education." }
    end
  end

  def create_experience
    @experience = @cv.experiences.create(experience_params)
    if !@experience.save
      flash[:error] = "Something went wrong!"
      redirect_to configure_cv_cv_path(@cv.id)
    else
      flash[:success] = "Added succesfully!"
      redirect_to configure_cv_cv_path(@cv.id)
    end
  end

  def update_experience
    experience = @cv.experiences.find(params[:id])
  
    if experience.update(experience_params)
      render json: { message: "Experience updated." }
      return
    else
      render json: { message: "Failed to update experience." }
      return
    end
  end

  def add_skills
    
    @cv.skills.destroy_all
    selected_skill_ids = skills_params[:skill_ids]
  
    if selected_skill_ids.present?
      selected_skills = Skill.where(id: selected_skill_ids)
  
      @cv.skills << selected_skills
  
      if @cv.save
        render json: { message: "Skills saved." }
        return
      else
        render json: { message: "Failed to save skills." }
        return
      end
    else
      render json: { message: "No skills selected." }
      return
    end
  end
  

  def delete_experience
    @experience = @cv.experiences.find(params[:id])
    if @experience.destroy
      render json: { message: "Delete successful." }
      return
    else
      render json: { message: "Failed to delete experience." }
      return
    end
  end

  def delete_education
    @education = @cv.educations.find(params[:id])
    if @education.destroy
      render json: { message: "Delete successful." }
      return
    else
      render json: { message: "Failed to delete education." }
      return
    end
  end

  def render_form
    @cv = Cv.find(params[:id])
    @education = Education.new
    @experience = Experience.new
    @name = ""
    if params[:education].present?
      @name = "education"
    elsif params[:experience].present?
      @name = "experience"
    end
    respond_to do |format|
      format.js { render layout: false }
    end
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
