require 'mysql2'
require './item'
require './category'

# Initialize DB
def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "Haqqutata06",
        :database => "food_oms_db"
    )

    client
end

def get_all_items
    client = create_db_client
    rawData = client.query("SELECT * FROM items")

    items = Array.new

    rawData.each do | data |
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end

    items
end

def get_all_categories
    client = create_db_client
    rawData = client.query("SELECT * FROM categories")

    categories = Array.new

    rawData.each do | data |
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end

    categories
end

def create_new_item(name, price, category_name = nil)
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{name}', '#{price}')")

    item_data = client.query("SELECT id FROM items WHERE name = '#{name}'")
    item_id = nil
    item_data.each do | data |
        item_id = data["id"]
    end

    if category_name != "None"
        category_data = client.query("SELECT id FROM categories WHERE name = '#{category_name}'")
        category_id = nil
        category_data.each do | data |
            category_id = data["id"]
        end

        client.query("INSERT INTO item_categories(item_id, category_id) VALUES(#{item_id}, #{category_id})")
    end
end

def get_item_with_id(id)
    client = create_db_client
    rawData = client.query("
        SELECT i.*, c.id AS 'category_id', c.name AS 'category_name'
        FROM items i
        LEFT JOIN item_categories ic ON i.id = ic.item_id
        LEFT JOIN categories c ON ic.category_id = c.id
        WHERE i.id = #{id}
    ")
    puts(rawData.each)

    item = nil

    rawData.each do | data |
        category = Category.new(data["category_id"], data["category_name"])
        item = Item.new(data["id"], data["name"], data["price"], category)
    end

    item
end

def delete_item_with_id(id)
    client = create_db_client

    client.query("DELETE FROM item_categories WHERE item_id = #{id}")
    client.query("DELETE FROM items WHERE id = #{id}")
end

def edit_item_with_id(id, name, price, category_name)
    client = create_db_client
    client.query("UPDATE items SET name = '#{name}', price = #{price} WHERE id = #{id}")

    client.query("DELETE FROM item_categories WHERE item_id = #{id}")

    if category_name != "None"
        category_data = client.query("SELECT id FROM categories WHERE name = '#{category_name}'")
        category_id = nil
        category_data.each do | data |
            category_id = data["id"]
        end

        client.query("INSERT INTO item_categories(item_id, category_id) VALUES(#{id}, #{category_id})")
    end
end