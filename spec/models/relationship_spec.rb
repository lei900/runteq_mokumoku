require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe 'validation' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    let!(:relationship) { build(:relationship, follower_id: user_a.id,
                                               followed_id: user_b.id) }
    it "should be valid" do
      expect(relationship).to be_valid
    end

    it "should require a follower_id" do
      relationship.follower_id = nil
      expect(relationship).to_not be_valid
    end

    it "should require a followed_id" do
      relationship.followed_id = nil
      expect(relationship).to_not be_valid
    end
  end
end
