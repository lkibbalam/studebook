# frozen_string_literal: true

shared_examples_for 'authenticate request' do
  it 'when request' do
    expect(response).to have_http_status(200)
  end
end

shared_examples_for 'non authenticate request' do
  it 'when request' do
    expect(response).to have_http_status(401)
  end
end

shared_examples_for 'response body with 10 objects' do
  it 'return 10 of resource objects' do
    expect(JSON.parse(response.body)['data'].size).to eq 10
  end
end
