require 'timecop'
require 'orderly'

feature 'User peeps' do

  scenario 'can be written' do
    sign_up
    fill_in :content, with: 'My first peep!'
    click_button 'Post'
  end

  scenario 'can be posted' do
    sign_up
    fill_in :content, with: 'My first peep!'
    click_button 'Post'
    expect(page).to have_content 'My first peep!'
  end

end

feature 'All peeps' do

  scenario 'can be seen without logging in' do
    sign_up
    fill_in :content, with: 'A peep here'
    click_button 'Post'
    click_button 'Log out'
    expect(page).to have_content 'A peep here'
  end

  scenario 'are displayed in reverse chronological order' do
    sign_up
    fill_in :content, with: 'Oldest!'
    click_button 'Post'
    fill_in :content, with: 'Newest!'
    click_button 'Post'
    expect('Newest').to appear_before('Oldest')
  end

  scenario 'show time created' do
    Timecop.freeze
    sign_up
    fill_in :content, with: 'Time test!'
    click_button 'Post'
    expect(page).to have_content Time.now.strftime('%a, %d %b %Y, %H:%M:%S')
  end

  scenario 'show user who wrote them' do
    sign_up
    fill_in :content, with: 'Can you see my name next to the peep?..'
    click_button 'Post'
    click_button 'Log out'
    expect(page).to have_content '@chitter_forever'
    expect(page).to have_content 'C.H Itter'
  end

end
