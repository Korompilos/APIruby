require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # Αρχικοποίηση δεδομένων
  let(:user) { create(:user) }
  # Δημιουργούμε 10 todos που ανήκουν στον χρήστη (created_by)
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }
  # Headers με το JWT token
  let(:headers) { valid_headers }

  # Test suite για GET /todos
  describe 'GET /todos' do
    # Περνάμε τα headers σε κάθε κλήση
    before { get '/todos', params: {}, headers: headers }

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite για GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite για POST /todos
  describe 'POST /todos' do
    # Ορίζουμε τις παραμέτρους ως Hash (ΧΩΡΙΣ .to_json εδώ)
    let(:valid_attributes) do
      { title: 'Learn Elm', created_by: user.id.to_s }
    end

    context 'when the request is valid' do
      # Μετατρέπουμε σε JSON ΜΙΑ φορά εδώ
      before { post '/todos', params: valid_attributes.to_json, headers: headers }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # Στέλνουμε κενό τίτλο σε μορφή JSON
      before { post '/todos', params: { title: nil }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite για PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite για DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end