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
end
