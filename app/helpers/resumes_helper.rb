module ResumesHelper
  def resume_template_link(user, resume)
    if resume.paid?
      new_user_resume_path(user, theme: resume.theme)
    else
      new_user_resume_payment_path(user, resume)
    end
  end
end
