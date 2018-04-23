shared_examples_for 'Commentable_comment' do
  let(:ancestry) { subject.id if subject.class.name == 'Comment' }
  before do
    get "/api/v1/#{subject.class.name.downcase.pluralize}/#{subject.id}/comments", headers: authenticated_header(user)
  end

  it 'should to appear all comments of commentable' do
    create_list(:comment, 10, parent_id: ancestry, commentable: subject)
    expect(subject.comments.count).to eq(10)
  end
end

shared_examples_for 'Commentable_create' do
  let(:create_comment) do
    post "/api/v1/#{subject.class.name.downcase.pluralize}/#{subject.id}/create_comment",
         params: { id: subject, comment: attributes_for(:comment) }, headers: authenticated_header(user)
  end

  it 'save new comment to commentable' do
    expect { create_comment }.to change(Comment, :count).by(1)
  end
end

shared_examples_for 'Commentable_update' do
  let!(:comment) { create(:comment, commentable: subject) }
  before do
    patch "/api/v1/#{subject.class.name.downcase.pluralize}/#{subject.id}/update_comment",
          params: { comment_id: comment.id, comment: { body: 'NewBody' } }, headers: authenticated_header(user)
  end

  it 'should to update a comment' do
    expect(subject.comments.first.body).to eq('NewBody')
  end
end

shared_examples_for 'Commentable_destroy' do
  let!(:comment) { create(:comment, commentable: subject) }
  let(:destroy_comment) do
    delete "/api/v1/#{subject.class.name.downcase.pluralize}/#{subject.id}/destroy_comment",
           params: { comment_id: comment.id }, headers: authenticated_header(user)
  end

  it 'should to delete a comment' do
    expect { destroy_comment }.to change(Comment, :count).by(-1)
  end
end
