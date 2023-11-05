# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create users
# db/seeds.rb

# Create 50 users with associated UserInformation records
# db/seeds.rb

# First code block: Creating users, their information, skills, CVs, education, and experience

20.times do |n|
  @user = User.create(email: "user#{n + 1}@example.com", password: "password#{n + 1}")
  UserInformation.create(
    first_name: "First#{n + 1}",
    last_name: "Last#{n + 1}",
    country: "Country#{n + 1}",
    county: "County#{n + 1}",
    city: "City#{n + 1}",
    address: "#{n + 1} Example St",
    birthdate: Date.new(1990, 1, 1) + n.days,
    sex: n.even? ? 'Male' : 'Female',
    phone_number: "0123456789",
    user_id: @user.id
  )
  skill = Skill.create(title: "Skill #{n + 1}")
  @cv = Cv.create(title: "CV Title #{n + 1}", user_id: @user.id)

  Education.create(
    institution: "University#{n + 1}",
    specialization: "Specialization#{n + 1}",
    degree: "Degree#{n + 1}",
    started_at: Date.new(2000, 1, 1) + n.days,
    finished_at: Date.new(2004, 1, 1) + n.days,
    ongoing: false,
    cv_id: @cv.id
  )
  Experience.create(
    title: "Job Title#{n + 1}",
    employer: "Employer#{n + 1}",
    description: "Description for Experience#{n + 1}",
    started_at: Date.new(2005, 1, 1) + n.days,
    finished_at: Date.new(2007, 1, 1) + n.days,
    ongoing: false,
    cv_id: @cv.id
  )
  @cv.skills << skill
end

# Second code block: Creating company information, jobs, and job applications
20.times do |n|
  @company_user = User.create(email: "company#{n + 1}@example.com", password: "password#{n + 1}", company: true)
  CompanyInformation.create(
    name: "Company #{n+1}",
    country: "Country #{n+1}",
    address: "Address #{n+1}",
    phone_number: "0123456789",
    user_id: @company_user.id
  )

  10.times do |m|
    @job = Job.create(
      title: "Job for #{n+m+1}",
      description: "Description for Job #{n+m+1}",
      user_id: @company_user.id
    )

    @job.skills << Skill.find_by(title: "Skill #{m + 1}")

    Cv.all.sample(4).each do |cv|
      Application.create(cv_id: cv.id, job_id: @job.id)
    end
  end
end


json_data = File.read(Rails.root.join('db/cities', 'cities.json'))
cities = JSON.parse(json_data)

cities.each do |city_data|
  Location.find_or_create_by(city: city_data['city'])
end