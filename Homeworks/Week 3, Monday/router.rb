require 'sinatra'
require './db_connector'

get '/' do
    items = get_all_items

    erb :index, locals: {
        items: items
    }
end

get '/items/new' do
    categories = get_all_categories

    erb :create_item, locals: {
      categories: categories
    }
end

get '/items/edit/:id' do
    id = params['id']
    item = get_item_with_id(id)
    categories = get_all_categories

    erb :edit_item, locals: {
      item: item,
      categories: categories
    }
end

get '/items/details/:id' do
    id = params['id']
    item = get_item_with_id(id)

    erb :item_details, locals: {
      item: item
    }
end

get '/items/delete/:id' do
    id = params['id']
    delete_item_with_id(id)

    redirect '/'
end

post '/items/create' do
    name = params['name']
    price = params['price']
    category_name = params['category_name']

    create_new_item(name, price, category_name)
    redirect '/'
end

post '/items/edit/:id' do
    id = params['id']
    name = params['name']
    price = params['price']
    category_name = params['category_name']

    edit_item_with_id(id, name, price, category_name)
    redirect '/'
end