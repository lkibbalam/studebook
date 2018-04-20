shared_examples_for 'authenticate request' do
  it 'when request' do
    expect(response).to have_http_status(:success)
  end
end

shared_examples_for 'non authenticate request' do
  it 'when request' do
    expect(response).to have_http_status(:unauthorized)
  end
end

shared_examples_for 'resource contain' do
  it 'returns all teams' do
    expect(JSON.parse(response.body).size).to eq 10
  end
end
