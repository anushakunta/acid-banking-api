Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "/up", to: proc { [200, {}, ['OK']] }
end
