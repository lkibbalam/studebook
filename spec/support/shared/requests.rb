shared_examples_for 'request' do
  it 'when request' do
    expect(response).to have_http_status(:success)
  end
end

shared_examples_for 'resource contain' do
  it 'returns all teams' do
    expect(JSON.parse(response.body).size).to eq 10
  end
end

shared_examples_for 'resource attributes' do
  subject.each do |attr|
    it "user object contains #{attr}" do
      expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path(attr)
    end
  end
end
