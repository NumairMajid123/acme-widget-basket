# Acme Widget Co – Shopping Basket

Acme Widget Shopping Basket is a proof-of-concept shopping basket system for Acme Widget Co.
It supports product pricing, shipping rules, and special promotions like "buy one red widget, get the second half price".

## Features
- Small, focused classes with clear interfaces
- Strategy pattern for shipping and promotions
- Dependency injection for rules and product catalog
- Decimal operations via `BigDecimal` to avoid float errors
- Minitest unit tests


## Assumptions
- Shipping charges apply **after** promotions are applied.
- Multiple promotions can be injected.
- Unknown product codes raise an error.

## Repository Structure

```
acme-widget-basket/
├─ README.md
├─ Rakefile
├─ main.rb
├─ lib/
│  ├─ acme_basket.rb
│  ├─ product_catalogue.rb
│  ├─ product.rb
│  ├─ shopping_basket.rb
│  ├─ shipping_calculator.rb
│  └─ promotions/
│     ├─ promotion.rb
│     └─ red_widget_promotion.rb
└─ test/
   ├─ test_helper.rb
   ├─ shopping_basket_test.rb
   ├─ shipping_calculator_test.rb
   └─ promotions_test.rb
```

## How It Works

### Product Catalog & Products
The shopping basket is initialized with a product catalog containing products (`R01`, `G01`, `B01`) including their names and prices.

### Adding Items
Use the `ShoppingBasket#add` method (or pass product codes via `main.rb`) to add items. Invalid codes are detected and reported.

### Promotions & Discounts
Special promotions (like "buy one red widget, get the second half price") are implemented as separate classes extending a base `Promotion` class. The basket applies all promotions automatically when calculating the total.

### Shipping Rules
Shipping cost is calculated based on the subtotal using a `ShippingCalculator`. Orders over $90 are free, orders $50–$89.99 cost $2.95, and orders under $50 cost $4.95.

### Calculating Total
The basket computes the base total, subtracts any discounts from promotions, adds shipping charges, and rounds to two decimal places for the final total.

### Extensibility
New products, promotions, or shipping rules can be added easily without changing the core basket logic. Each rule lives in its own class, keeping the system modular and maintainable.

## Examples To Run

```
ruby main.rb R01 G01 -> $60.85

ruby main.rb R01 R01 -> $54.37

ruby main.rb  B01 B01 R01 R01 R01 -> $98.27
```

## Run Test cases

```
rake 

or 

rake test
```
