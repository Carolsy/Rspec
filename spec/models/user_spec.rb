require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "adds 2 and 3 to make 5" do
    expect(2+3).to eq(5)
  end

  it "is valid with a first name, last name, email, and password" do
    user = User.new(
        first_name: "Aaron",
        last_name:  "Sumner",
        email:      "tester@example.com",
        password:   "dottle-nouveau-pavilion-tights-furze",
        )
    expect(user).to be_valid
  end

  it "is invalid without a firstname" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "has a valid factory" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    expect(user).not_to be_valid
  end

  it "is invalid when two users share one email" do
    FactoryBot.create(:user, email: "bob@qq.com")
    user = FactoryBot.build(:user, email: "bob@qq.com")
    expect(user.errors[:email]).to include("has already been taken")
    #expect(user).to be_valid
  end

  it "generates associated data from a factory" do
    u = FactoryBot.create(:user)
    puts "This u user is #{u.first_name}"
    puts "This u user is #{u.email}"
  end
end
