# Seat Yourself

## To do

- Make restaurant controller methods for edit, update, destroy check the current user before executing.

```ruby
@restaurant.owner == current_user
```



## Suggestions

### Proximity search

I think we already talked about this, but I thought it would help to write it down.

One way we could filter restaurants by area is by creating a table called locations with this structure:

```ruby
create_table :landmarks do |t|
  t.string :name
end

create_table :distances do |t|
  t.integer :landmark_id
  t.integer :restuarant_id
  t.integer :radius
end
```

For a given landmark and restaurant, the distances table has an entry with
the distance between them, rounded to the nearest km.

This will make it easier for people to select a location from a list and
filter by the maximum distance.


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
