require 'spec_helper'

describe User do
  it { should have_many :reviews }
  it { should validate_presence_of :username }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password).on :create }
  it { should validate_length_of(:password).is_at_least 6 }
end
