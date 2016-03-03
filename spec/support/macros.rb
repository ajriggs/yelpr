# unit/controller helpers

def test_login(user:)
  session[:user_id] = user.id
end

# feature helpers

def log_in(user:)
  visit login_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log In'
end
