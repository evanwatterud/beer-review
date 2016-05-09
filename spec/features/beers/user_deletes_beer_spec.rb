require 'rails_helper'

feature 'user deletes beer' do
  scenario 'authenticated user deletes beer they created'
  scenario 'authenticated user tries to delete beer they did not create'
end
