class UserMailer < ApplicationMailer

  def send_job_recommendation(user, jobs)
    @user = user
    @jobs = jobs
    mail(to: @user.email, subject: 'These jobs are the best matches!')
  end

end
