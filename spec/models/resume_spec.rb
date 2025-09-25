require 'rails_helper'

RSpec.describe Resume, type: :model do
  let(:user) { User.create!(email: Faker::Internet.email, password: "password123") }

  describe "validations" do
    it "is vaid with valid atributes" do
      resume=Resume.new(
        user: user,
        name: "Oscar Williams",
        theme: "neon",
        bio: "Passionate software engineer",
      )
      expect(resume).to be_valid
    end
  end

  it "is not valid without a user" do
    resume=Resume.new(
      name: "Oscar Williams",
      theme: "neon",
      bio: "Passionate software engineer",
    )
    expect(resume).not_to be_valid
  end
end
