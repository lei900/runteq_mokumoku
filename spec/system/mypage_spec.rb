require 'rails_helper'

RSpec.describe 'Mypage', type: :system do
  include_context 'user setup'

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
  end

  def expect_unfollow_buttons_behave_normal
    expect(page).to have_content other_user.name
    click_unfollow_button
    expect_follow_button
    click_follow_button
    expect_unfollow_button
  end
end