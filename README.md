# EaseMart-API

An e-commerce backend API built with Django and Django REST Framework (DRF), enabling functionality for product management, user account handling, category browsing, and purchase processing. This API powers the backend for EaseMart, an e-commerce platform.

## Features
- User Authentication (Registration, Login, Activation)
- Product Listing and Management
- Cart Management (Add, View, Remove items)
- Purchase Processing
- Profile Management for Customers and Sellers
- Category Management

## Technologies Used
- **Django**
- **Django REST Framework (DRF)**
- **HTML, CSS, JavaScript** for additional static content

---

## API Documentation

Below is a detailed outline of available endpoints across different modules.

---

### 1. **Categories**

Routes for managing product categories.

| Method | Endpoint            | Description                   |
|--------|----------------------|-------------------------------|
| GET    | `/categories/`      | List all categories           |
| POST   | `/categories/`      | Create a new category         |

---

### 2. **Dashboard**

User-specific routes for managing customer and seller profiles, viewing purchases, and listing seller products.

#### Customer-Specific Endpoints

| Method | Endpoint                    | Description                     |
|--------|------------------------------|---------------------------------|
| GET    | `/dashboard/customer/purchases/` | List all purchases by the customer |
| GET    | `/dashboard/customer/cart/`      | View all items in customer's cart  |
| PUT    | `/dashboard/profile/customer/`    | Update customer profile             |

#### Seller-Specific Endpoints

| Method | Endpoint                          | Description                         |
|--------|------------------------------------|-------------------------------------|
| GET    | `/dashboard/seller/products/`      | List all products added by seller   |
| GET    | `/dashboard/seller/products/<int:pk>/` | Retrieve a specific seller product  |
| PUT    | `/dashboard/profile/seller/`       | Update seller profile               |

---

### 3. **Products**

Handles product listings, cart operations, and purchasing.

| Method | Endpoint                           | Description                                       |
|--------|------------------------------------|---------------------------------------------------|
| GET    | `/products/products/`              | List all products                                 |
| POST   | `/products/products/`              | Add a new product                                 |
| GET    | `/products/cart/`                  | Retrieve items in the cart                        |
| POST   | `/products/cart/add/<int:product_id>/` | Add a specific product to the cart               |
| DELETE | `/products/cart/remove/<int:cart_item_id>/` | Remove a specific item from the cart           |
| POST   | `/products/purchase/`              | Purchase items in the cart                        |

---

### 4. **Users**

User authentication and account management, including registration, login, and activation.

| Method | Endpoint                           | Description                                       |
|--------|------------------------------------|---------------------------------------------------|
| POST   | `/users/register/`                 | Register a new user                               |
| POST   | `/users/login/`                    | Log in an existing user                           |
| GET    | `/users/activate/<uid64>/<token>/` | Activate a user account (via email link)          |
| GET    | `/users/user-accounts/`            | Retrieve user account details                     |
| GET    | `/users/users/`                    | List all users                                    |

---

## Installation and Setup

To set up the EaseMart API on your local machine, follow these commands in sequence:

```bash
# Clone the repository
git clone https://github.com/username/EaseMart-API.git

# Navigate to the project directory
cd EaseMart-API

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Start the development server
python manage.py runserver
