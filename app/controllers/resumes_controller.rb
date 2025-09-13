class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  before_action :authorize_resume!, only: [:edit, :update, :destroy]

  def index
    @resumes=Resume.all
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "resume_#{@resume.id}",
        templates: "resumes/show.pdf.erb",
        locals: {resume: @resume}
      end
    end
  end

  def new
    if current_user.resume.present?
      redirect_to edit_user_resume_path(current_user, current_user.resume)
    else
      @resume=current_user.build_resume
      2.times {@resume.projects.build}
      3.times {@resume.skills.build}
    end
  end

  def create
    @resume=current_user.build_resume(resume_params)
    if @resume.save
      redirect_to root_path, notice: "Resume created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to user_resumes_path, notice: "Resume updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resume.destroy
    redirect_to root_path, notice: "Resume deleted"
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def authorize_resume!
    unless @resume.user==current_user
      redirect_to root_path, alert: "Not authorized to edit this resume"
    end
  end

  def resume_params
    params.require(:resume).permit(:name, :slug, :bio, :theme, projects_attributes: [:id, :title, :summary, :url, :_destroy], skills_attributes: [:id, :name])
  end

end
