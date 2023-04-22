Rails.application.routes.draw do
  root to: "application#home"

  get "admin/list_bookings", to: "admin#list_bookings", as: "admin_list_bookings"
  get "bookings/new", to: "bookings#new", as: "new_booking"
  post "bookings", to: "bookings#create", as: "create_booking"
  get "bookings/:id", to: "bookings#show", as: "booking"
  get "pricing_engine/get_price", to: "pricing_engine#get_price", as: "calc_price"
end
