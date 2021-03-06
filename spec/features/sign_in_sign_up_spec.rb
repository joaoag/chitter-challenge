feature 'User access' do
  
  scenario 'page shows sign in and sign up options' do
    visit '/'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end
  
  scenario 'user can sign up' do
    sign_up
    expect(page).to have_content 'Hello, C.H Itter!'
  end

  scenario 'user can log out' do
    sign_up
    click_button 'Log out'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end

  scenario 'user can sign in' do
    sign_up
    click_button 'Log out'
    sign_in
    expect(page).to have_content 'Hello, C.H Itter!'
  end

end

feature 'User authentication' do
  
  scenario 'unique email required to sign up' do
    sign_up
    click_button 'Log out'
    click_button 'Sign in'
    fill_in :email, with: 'chitter@chittering.com'
    fill_in :password, with: 'wrongpassword321'
    click_button 'Sign in'
    expect(page.current_path).to eql '/'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end

  scenario 'correct password required to sign in' do
    sign_up
    click_button 'Log out'
    click_button 'Sign in'
    fill_in :email, with: 'chitter@chittering.com'
    fill_in :password, with: 'wrongpassword321'
    click_button 'Sign in'
    expect(page.current_path).to eql '/'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end

  scenario 'correct email required to sign in' do
    sign_up
    click_button 'Log out'
    click_button 'Sign in'
    fill_in :email, with: 'wrongemail@wrongemail.com'
    fill_in :password, with: 'gnirettihc123'
    click_button 'Sign in'
    expect(page.current_path).to eql '/'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end

end
