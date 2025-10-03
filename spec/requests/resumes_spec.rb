require 'rails_helper'

RSpec.describe "Resumes", type: :request do

  before do
    @user = User.create(email: Faker::Internet.email, password: "password123")
    @resume = @user.resumes.create(user: @user, name: "Software Engineer Jr", bio: "Passionate Software Engineer", slug: "soft-engineer", theme: "neon")
  end

  describe "get all resumes" do
    it "displays all resumes" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
      expect(response.body).to include("All Resumes")
    end
  end

  describe "creates a resume" do
    before { sign_in(@user) }

    it "creates a resume" do
      expect(@resume.name).to eq("Software Engineer Jr")
      expect(@resume.theme).to eq("neon")

      expect {post user_resumes_path(@user), params: {
        resume: {name: "Alex Hussain", bio: "Dentist", theme: "classic"}
      }}.to change(Resume, :count).by(1)
    end

    it "should not create a resume with invalid params" do

      expect {post user_resumes_path(@user), params: {
        resume: { name: "", bio: "web developer", theme: "dark"}
      }}.not_to change(Resume, :count)
    end
  end

  describe "get resumes of current user" do
    before { sign_in(@user) }

    it "lists resume of signed in users" do
      get my_resumes_user_resumes_path(@user)
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:user_id/resumes/:id" do
    before { sign_in(@user) }
    
    it "renders the show page" do
      get user_resume_path(@user, @resume)
      expect(response).to have_http_status(:ok)
    end

    it "renders resume as pdf" do
      get user_resume_path(@user, @resume, format: :pdf)
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("application/pdf")
    end
  end

  describe "GET /users/:user_id/resumes/new" do
    before { sign_in(@user) }

    it "should render the new resume form" do
      get new_user_resume_path(@user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DESTROY /users/:user_id/resumes/:id" do
    before { sign_in(@user) }

    it "deletes the resume" do
      expect {delete user_resume_path(@user,@resume)}.to change(Resume, :count).by(-1)
    end
  end

end
