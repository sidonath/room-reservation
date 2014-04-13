require 'spec_helper'

feature 'Home page' do
  it 'successfully visits the home page' do
    visit '/'

    expect(page.body).to match('Hello, World!')
  end
end
