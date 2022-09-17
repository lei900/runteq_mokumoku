module LoginSupport
  def login_as(user)
    visit root_path
    click_on "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "ログイン"
  end
end
