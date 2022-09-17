require 'rails_helper'

RSpec.describe 'Users', type: :system do
  include_context 'user setup'
  
  describe 'ユーザー詳細ページ' do
    context '自分の詳細ページ' do
      it 'フォロ関連数字のみが表示される' do
        click_on 'user'
        expect_following_stats
        expect(page).not_to have_button 'フォローする' or have_button 'フォロー解除'
      end

      it 'イベントタブ内容が表示される' do
        create(:bookmark, user: user, event: other_event)
        click_on user.name
        expect(page).to have_content '他人が主催するもくもく会'
      end
    end

    context '他ユーザーの詳細ページ' do
      it 'フォロ関連数字とフォロボタンが表示される' do
        click_on 'other_user'
        expect_following_stats
        expect_follow_button
      end

      it '他ユーザーに対してフォロとフォロ解除ができる' do
        click_on 'other_user'
        expect(page).to have_selector '#followers', text: '0'
        click_follow_button
        expect(page).to have_selector '#followers', text: '1'
        click_unfollow_button
        expect(page).to have_selector '#followers', text: '0'
      end

      it '他ユーザーのイベントタブ内容が表示される' do
        create(:bookmark, user: other_user, event: my_event)
        click_on 'other_user'
        expect(page).to have_content '自分が主催するもくもく会'
      end
    end
  end

  def expect_following_stats
    expect(page).to have_selector '#following', text: '0'
    expect(page).to have_selector '#followers', text: '0'
    expect(page).to have_content 'フォロー中'
    expect(page).to have_content 'フォロワー'
  end
end