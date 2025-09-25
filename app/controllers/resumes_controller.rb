class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  before_action :authorize_resume!, only: [:edit, :update, :destroy]

  def index
    @resumes=Resume.order(created_at: :desc).limit(3)
  end

  def my_resumes
    @resumes=current_user.resumes.order(created_at: :desc)
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
    @resume=current_user.resumes.build(theme: params[:theme])
    2.times {@resume.projects.build}
    3.times {@resume.skills.build}
  end

  def create
    @resume=current_user.resumes.build(resume_params)
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
    params.require(:resume).permit(:name, :slug, :bio, :theme, projects_attributes: [:id, :title, :summary, :url, :_destroy], skills_attributes: [:id, :name, :_destroy], experiences_attributes: [:id, :position, :company_name, :summary, :date_from, :date_to, :currently_working, :_destroy])
  end

end
