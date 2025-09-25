require 'faker'
User.destroy_all
Resume.destroy_all
Skill.destroy_all
Project.destroy_all
Experience.destroy_all

themes=['clean', 'dark', 'neon']

themes.each do |theme|
  user=User.create({
    email: "#{theme}@example.com",
    password: "Pass123"
  })
  puts "User #{user.email} created"

  resume=Resume.create({
    user: user,
    name: "#{theme} resume",
    bio: Faker::Markdown.emphasis,
    theme: theme
  })
  puts "Resume #{resume.name} created"
  
  5.times do
    skill=Skill.create({
      resume: resume,
      name: Faker::ProgrammingLanguage.name
    })
    puts "Skill #{skill.name} created"
  end
  
  3.times do 
    project=Project.create({
      resume: resume,
      title: Faker::Game.title,
      summary: Faker::Quote.famous_last_words,
      url: "www.google.com"
    })
  end

  experience=Experience.create({
    resume: resume,
    position: "Software Engineer",
    summary: "Building useful softwares to be used by different clients",
    date_from: Date.new(2020, 1, 1),
    date_to: Date.new(2022, 5, 1),
    currently_working: false,
    company_name: "Tech Corp"
  })
  puts "Experience #{experience.position} Created"

  experience=Experience.create({
    resume: resume,
    position: "Web Developer",
    summary: "Leading a team of developers to design scalable backend systems",
    date_from: Date.new(2022, 6, 1),
    currently_working: true,
  })
  puts "Experience #{experience.position} Created"

end
