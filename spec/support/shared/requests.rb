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
