require 'api/api'

Rails.application.routes.draw do
  mount API::API => '/'
end
