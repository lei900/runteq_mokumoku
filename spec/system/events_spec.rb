require 'rails_helper'

RSpec.describe 'Events', type: :system do
  include_context 'user setup'

  describe 'イベント一覧ページ' do
    it 'ユーザー名をクリックしてユーザー詳細ページへ遷移できる' do
      expect_access_user_show_page(user)
    end
  end

  describe 'イベント詳細ページ' do
    describe 'ユーザー詳細ページへの遷移' do
      it 'ユーザー名をクリックしてユーザー詳細ページへ遷移できる' do
        click_on '他人が主催するもくもく会'
        expect_access_user_show_page(other_user)
      end
    end

    describe 'フォロとフォロ解除' do
      context '自分が主催するイベントの詳細ページ' do
        it 'フォローボタンが表示されない' do
          click_on '自分が主催するもくもく会'
          expect_button_not_show
        end
      end

      context '他人が主催するイベントの詳細ページ' do
        it 'フォロとフォロ解除ができる' do
          click_on '他人が主催するもくもく会'
          expect_follow_buttons_behave_normal
        end
      end
    end
  end

  def expect_access_user_show_page(user)
    click_on user.name
    expect(page).to have_content user.email
  end
end
