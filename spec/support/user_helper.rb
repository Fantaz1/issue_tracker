def sign_in user
  visit root_path
  click_link 'Sign in'
  within "#new_user" do
    fill_in "user_name", with: user.name
    fill_in "user_password", with: '12345678'
    find('[type=submit]').click
  end
end