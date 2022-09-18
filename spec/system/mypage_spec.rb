require 'rails_helper'

RSpec.describe 'Mypage', type: :system do
  include_context 'user setup'
  let(:diffent_user) { create(:user, name: 'different_user') }
  let(:diffent_event) { create(:event, title: '第三者が主催するもくもく会', user: diffent_user) }
  let(:user_attend_diffent_event) { user_attend_diffent_event }

  before do
    create(:relationship, follower_id: user.id, followed_id: other_user.id)
    create(:relationship, follower_id: other_user.id, followed_id: user.id)
    visit mypage_root_path
  end

  describe 'マイページ' do
    describe 'フォロとフォロワー管理' do
      it 'フォロ関連数字が表示される' do
        expect(page).to have_selector '#following', text: '1'
        expect(page).to have_selector '#followers', text: '1'
      end

      it 'フォロ中リストからユーザーをフォロまたはフォロ解除できる' do
        click_on 'フォロー中'
        expect_unfollow_buttons_behave_normal
      end

      it 'フォロワーリストからユーザーをフォロまたはフォロ解除できる' do
        click_on 'フォロワー'
        expect_unfollow_buttons_behave_normal
      end
    end

    describe '通知設定' do
      describe 'フォロー中のユーザーがイベントに参加した時' do
        it '通知をonとoffに設定できる' do
          click_on '通知設定'
          expect(page).to have_content 'フォロー中のユーザーがイベントに参加した時'
          click_following_attended_event_setting_button
          expect(user.allow_following_attended_to_event_notification?).to be true
          click_following_attended_event_setting_button
          expect(user.allow_following_attended_to_event_notification?).to be false
        end
      end
    end

    describe '通知一覧' do
      describe 'フォロー中のユーザーがイベントに参加した時の通知' do
        context 'フォロー中のユーザーが第三者が作成したイベントに参加した時' do
          before do
            user_attend_diffent_event
            logout
            login_as(other_user)
            visit mypage_root_path
          end
          it '通知を表示できる' do
            click_on '通知一覧'
            expect(page).to have_content 'userが参加するイベントがありました'
          end
        end
      end
    end
  end

  def expect_unfollow_buttons_behave_normal
    expect(page).to have_content other_user.name
    click_unfollow_button
    expect_follow_button
    click_follow_button
    expect_unfollow_button
  end

  def click_following_attended_event_setting_button
    find('#user_notification_timing_ids_5').click
    click_on '更新する'
  end

  def user_attend_diffent_event
    visit event_path(diffent_event)
    expect(page).to have_content diffent_event.title
    click_on 'このもくもく会に参加する'
    page.driver.browser.switch_to.alert.accept
  end

  def logout
    find('.avatar.avatar-md').click
    find(:css, 'i.bi.bi-box-arrow-left.me-2').click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path login_path
  end
end
