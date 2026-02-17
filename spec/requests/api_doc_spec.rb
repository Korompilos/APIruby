require 'swagger_helper'

RSpec.describe 'Todos API Documentation', type: :request do
  # --- Authentication ---
  path '/signup' do
    post 'User Registration' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password password_confirmation]
      }
      response '201', 'Account created' do run_test! end
    end
  end

  path '/auth/login' do
    post 'User Login' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      response '200', 'Login successful' do run_test! end
    end
  end

  path '/auth/logout' do
    get 'User Logout' do
      tags 'Authentication'
      security [bearer_auth: []]
      response '200', 'Logout successful' do run_test! end
    end
  end

  # --- Todos ---
  path '/todos' do
    get 'List all todos and todo items' do
      tags 'Todos'
      security [bearer_auth: []]
      response '200', 'Todos retrieved' do run_test! end
    end

    post 'Create a new todo' do
      tags 'Todos'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: { title: { type: :string } },
        required: ['title']
      }
      response '201', 'Todo created' do run_test! end
    end
  end

  path '/todos/{id}' do
    parameter name: :id, in: :path, type: :string
    
    get 'Get a todo' do
      tags 'Todos'
      security [bearer_auth: []]
      response '200', 'Todo found' do run_test! end
    end

    put 'Update a todo' do
      tags 'Todos'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: { title: { type: :string } }
      }
      response '204', 'Todo updated' do run_test! end
    end

    delete 'Delete a todo and its items' do
      tags 'Todos'
      security [bearer_auth: []]
      response '204', 'Todo deleted' do run_test! end
    end
  end

  # --- Items ---
  path '/todos/{todo_id}/items' do
    parameter name: :todo_id, in: :path, type: :string

    post 'Create a new todo item' do
      tags 'Items'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string }, done: { type: :boolean } },
        required: ['name']
      }
      response '201', 'Item created' do run_test! end
    end
  end

  path '/todos/{todo_id}/items/{id}' do
    parameter name: :todo_id, in: :path, type: :string
    parameter name: :id, in: :path, type: :string

    get 'Get a todo item' do
      tags 'Items'
      security [bearer_auth: []]
      response '200', 'Item found' do run_test! end
    end

    put 'Update a todo item' do
      tags 'Items'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string }, done: { type: :boolean } }
      }
      response '204', 'Item updated' do run_test! end
    end

    delete 'Delete a todo item' do
      tags 'Items'
      security [bearer_auth: []]
      response '204', 'Item deleted' do run_test! end
    end
  end
end