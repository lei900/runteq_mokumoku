module FollowSupport
  def click_follow_button
    click_button 'フォローする'
  end

  def click_unfollow_button
    click_button 'フォロー解除'
  end

  def expect_follow_button
    expect(page).to have_button 'フォローする'
  end

  def expect_unfollow_button
    expect(page).to have_button 'フォロー解除'
  end

  def expect_button_not_show
    expect(page).not_to have_button 'フォロー解除' or have_button 'フォローする'
  end

  def expect_follow_buttons_behave_normal
    click_follow_button
    expect_unfollow_button
    click_unfollow_button
    expect_follow_button
  end
end
