# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationFacade, type: :model do
  include ActiveJob::TestHelper
  describe 'following_attended_to_event' do
    let(:event) { create(:event) }
    let(:allowed_user) do
      user = create(:user)
      user.notification_timings << NotificationTiming.find_by!(timing: :following_attended_to_event)
      user
    end
    let(:not_allowed_user) { create(:user) }
    let(:followed_user) do
      followed_user = create(:user)
      followed_user.followers << [allowed_user, not_allowed_user]
      followed_user
    end
    let(:event_attendance) { followed_user.attend(event) }
    subject(:mail) { ActionMailer::Base.deliveries.last }

    it '受信対象にメール通知が送信される' do
      perform_enqueued_jobs(only: ActionMailer::MailDeliveryJob) do
        NotificationFacade.following_attended_to_event(event_attendance, allowed_user)
        expect(mail.subject).to eq "#{followed_user.name}が参加するイベントがありました"
      end
    end

    it '受信拒否対象にメール通知が送信されない' do
      perform_enqueued_jobs(only: ActionMailer::MailDeliveryJob) do
        NotificationFacade.following_attended_to_event(event_attendance, not_allowed_user)
        expect(mail).to be_nil
      end
    end
  end
end
