# README

# Merchandising Store API

This is a simple API for a merchandising store. It allows you to manage products and calculate prices based on discounts.

## Setup

1. Clone the repository: `git clone https://github.com/blaz1988/merchandising-store.git`
2. Install required gems: `bundle install`
3. Create db: `bundle exec rake db:create`
4. Run database migrations: `bundle exec rake db:migrate`
5. Populate db data: `bundle exec rake db:seed`
6. Run the server: `bundle exec rails server`

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

Request 1:
```sh
curl "http://localhost:3000/api/v1/products/prices?items=1%20MUG,1%20TSHIRT,1%20HOODIE"
```

Response 1:
```sh
{"total":"41.0"}
```

Request 2:
```sh
curl "http://localhost:3000/api/v1/products/prices?items=2%20MUG,1%20TSHIRT"
```

Response 2:
```sh
{"total":"27.0"}
```

Request 3:
```sh
curl "http://localhost:3000/api/v1/products/prices?items=3%20MUG,1%20TSHIRT"
```

Response 3:
```sh
{"total":"33.0"}
```

Request 3:
```sh
curl "http://localhost:3000/api/v1/products/prices?items=2%20MUG,4%20TSHIRT,1%20HOODIE"
```

Response 3:
```sh
{"total":"92.0"}
```

### Get the total price for a given list of items with discounts applied.

Items parameter format: "Quantity ProductCode, Quantity ProductCode, ..."
Request 1:
```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=1%20MUG,1%20TSHIRT,1%20HOODIE"
```

Response 1:
```sh
{"total":"41.0"}
```

Request 2:
```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=9%20MUG,1%20TSHIRT"
```

Response 2:
```sh
{"total":"69.0"}
```

Request 3:
```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=10%20MUG,1%20TSHIRT"
```

Response 3:
```sh
{"total":"73.8"}
```

Request 4:
```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=45%20MUG,3%20TSHIRT"
```

Response 4:
```sh
{"total":"279.9"}
```

Request 5:
```sh
curl "http://localhost:3000/api/v1/products/prices-with-discounts?items=200%20MUG,4%20TSHIRT,1%20HOODIE"
```

Response 5:
```sh
{"total":"902.0"}
```

