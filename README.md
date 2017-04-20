# Seat Yourself

## Mockup

### Main Page

In order from top to bottom:
1. Sign in / sign up
2. Make a new reservation form
  - restaurants
  - number of people
  - time
3. List of promotions/specials
4. List of restaurants (will be filtered later)

### New reservation

After the new reservation form is submitted, if the user is not logged in, they
are asked to sign up so the contact information can be added.

### Profile Page

Will be done later

### Restaurant Page

Details about the restaurant. If the user is logged in, and they are the owner,
a list of reservations. Ability to approve or reject them?

## Models

### Reservation

Fields
  - user_id
  - restaurant_id
  - date/time
  - number of people
Associations:
  - belongs_to :user
  - belongs_to :restaurant

### Restaurant
  - name
  - address
  - phone
  - picture link
  - description
  - category_id
  - capacity
Associations:
  - has_many :users, through: :reservations
  - has_many :reservations

### User

 - email
 - name
 - password_digest
 - postal_code

### Category
 - name
 Associations
