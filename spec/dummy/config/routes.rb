Rails.application.routes.draw do
  resources :posts
  mount ResourceRenderer::Engine => '/resource_renderer'
end
