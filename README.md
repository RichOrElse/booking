# Booking

This is an exercise web app.

## Prerequisites

Install the following:
* Ruby
* SQLite
* Yarn

## Setup

Install Ruby gems:

    $ bundle install

Install Yarn packages:

    $ yarn install

Setup the database:

    $ rails db:migrate

Run the test:

    $ rspec --format doc

Run the server:

    $ rails server -p 3000

Then open on your browser [http://localhost:3000](http://localhost:3000)

## Demo

Book reservations with different payload formats.
Copy and paste the following to the payload text area, then click the Submit button.

### Service Payload Format 1

```json
{
  "reservation": {
    "start_date": "2020-03-12",
    "end_date": "2020-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_id": 1,
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4500.00"
  }
}
```

### Service Payload Format 2

```json
{
  "start_date": "2020-03-12",
  "end_date": "2020-03-16",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "id": 1,
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "3800.00",
  "security_price": "500",
  "total_price": "4500.00"
}
```
## Author

[@RichOrElse](github.com/RichOrElse) Ritchie Paul Buitre <ritchie@richorelse.com>


