# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'スコープ' do
    describe 'allowing_created_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :created_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_created_event_notification).to include(allowed_user)
        expect(User.allowing_created_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_commented_to_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :commented_to_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_commented_to_event_notification).to include(allowed_user)
        expect(User.allowing_commented_to_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_attended_to_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :attended_to_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_attended_to_event_notification).to include(allowed_user)
        expect(User.allowing_attended_to_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_liked_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :liked_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_liked_event_notification).to include(allowed_user)
        expect(User.allowing_liked_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_following_attended_to_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :following_attended_to_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_following_attended_to_event_notification).to include(allowed_user)
        expect(User.allowing_following_attended_to_event_notification).not_to include(not_allowed_user)
      end
    end
  end

  describe 'メソッド' do
    describe 'attend' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event) }
      it 'イベントへの参加処理が行われること' do
        expect do
          user.attend(event)
        end.to change { EventAttendance.count }.by(1)
      end
    end

    describe 'cancel_attend' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event) }
      before do
        user.attend(event)
      end
      it 'イベントへのキャンセル処理が行われること' do
        expect do
          user.cancel_attend(event)
        end.to change { EventAttendance.count }.by(-1)
      end
    end

    describe 'follow and unfollow' do
      let!(:user_a) { create(:user) }
      let!(:user_b) { create(:user) }
      it 'ユーザーに対してフォロとフォロ解除できる' do
        expect(user_a.following?(user_b)).to be false
        user_a.follow(user_b)
        expect(user_b.followers.include?(user_a)).to be true
        expect(user_a.following?(user_b)).to be true
        user_a.unfollow(user_b)
        expect(user_b.followers).not_to include(user_a)
      end
    end
  end
end
