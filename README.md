# README

# Merchandising Store API

This is a simple API for a merchandising store. It allows you to manage products and calculate prices based on discounts.

## Setup

1. Clone the repository: `git clone https://github.com/blaz1988/merchandising-store.git`
2. `cd merchandising-store`
3. Install required gems: `bundle install`
4. Create db: `bundle exec rake db:create`
4. Run database migrations: `bundle exec rake db:migrate`
4. Populate db data: `bundle exec rake db:seed`
5. Run the server: `bundle exec rails server`

## API Endpoints

### GET /api/v1/products

List all products.

**cURL example:**

```sh
curl http://localhost:3000/api/v1/products
```

### Get a specific product by ID.

**cURL example:**

```sh
curl http://localhost:3000/api/v1/products/1
```

### Update the price of a specific product by ID. You need to pass the `Authorization` header with the correct token.

**cURL example:**

```sh
curl -X PATCH -H "Authorization: 6b70e534d58061f80da87b071001ce49bb084c0954fb2d04e4366d24dec3ff4e" -H "Content-Type: application/json" -d '{"product": {"price": 57.0}}' http://localhost:3000/api/v1/products/1

```

### Get the total price for a given list of items.

Items parameter format: "Quantity ProductCode, Quantity ProductCode, ..."

**cURL example:**

```sh
curl "http://localhost:3000/api/v1/products/prices?items=1%20MUG,%201%20TSHIRT,%201%20HOODIE"
```

### Get the total price for a given list of items with discounts applied.

Items parameter format: "Quantity ProductCode, Quantity ProductCode, ..."

```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=45%20MUG,%203%20TSHIRT"
```
