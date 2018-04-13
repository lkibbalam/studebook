require 'rails_helper'

describe 'comment' do
  let!(:subject) { create(:comment, commentable: create(:comment, commentable: create(:course))) }

  describe 'GET #comments' do
    it_behaves_like 'Commentable_comment'
  end

  describe 'POST #create_comment' do
    it_behaves_like 'Commentable_create'
  end

  describe 'PATCH #update_comment' do
    it_behaves_like 'Commentable_update'
  end

  describe 'DELETE #destroy_comment' do
    it_behaves_like 'Commentable_destroy'
  end
end
