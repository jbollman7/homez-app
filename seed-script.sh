#!/bin/bash

# Define the JSON array
json_data='[
    {
        "id": 0,
        "name": "Acme Fresh Start Housing",
        "units": 4,
        "city": "Chicago",
        "laundry": true,
        "photo": "/assets/bernard-hermant-CLKGGwIBTaY-unsplash.jpg",
        "rental": true,
        "state": "IL",
        "wifi": true
    },
    {
        "id": 1,
        "name": "Sky High Housing",
        "units": 0,
        "city": "San Diego",
        "laundry": true,
        "photo": "/assets/brandon-griggs-wR11KBaB86U-unsplash.jpg",
        "rental": true,
        "state": "CA",
        "wifi": false
    },
    {
        "id": 2,
        "name": "Bed and Breakfast",
        "units": 1,
        "city": "Casper",
        "laundry": false,
        "photo": "/assets/i-do-nothing-but-love-lAyXdl1-Wmc-unsplash.jpg",
        "rental": false,
        "state": "WY",
        "wifi": false
    },
    {
        "id": 3,
        "name": "Suburban Housing",
        "units": 1,
        "city": "Chicago",
        "laundry": false,
        "photo": "/assets/ian-macdonald-W8z6aiwfi1E-unsplash.jpg",
        "rental": false,
        "state": "IL",
        "wifi": true
    },
    {
        "id": 4,
        "name": "Happy Homes Group",
        "units": 1,
        "city": "Salina",
        "laundry": false,
        "photo": "/assets/krzysztof-hepner-978RAXoXnH4-unsplash.jpg",
        "rental": false,
        "state": "KS",
        "wifi": true
    },
    {
        "id": 5,
        "name": "Hopeful Apartment Group",
        "units": 2,
        "city": "Kansas City",
        "laundry": true,
        "photo": "/assets/r-architecture-JvQ0Q5IkeMM-unsplash.jpg",
        "rental": true,
        "state": "KS",
        "wifi": true
    },
    {
        "id": 6,
        "name": "Seriously Safe Towns",
        "units": 5,
        "city": "Manhattan",
        "laundry": true,
        "photo": "/assets/phil-hearing-IYfp2Ixe9nM-unsplash.jpg",
        "rental": false,
        "state": "KS",
        "wifi": true
    },
    {
        "id": 7,
        "name": "Modern Homes",
        "units": 2,
        "city": "Lawrence",
        "laundry": true,
        "photo": "/assets/r-architecture-GGupkreKwxA-unsplash.jpg",
        "rental": false,
        "state": "KS",
        "wifi": true
    },
    {
        "id": 8,
        "name": "Condos & More",
        "units": 10,
        "city": "Atlanta",
        "laundry": false,
        "photo": "/assets/saru-robert-9rP3mxf8qWI-unsplash.jpg",
        "rental": false,
        "state": "GA",
        "wifi": false
    },
    {
        "id": 9,
        "name": "Capital Safe Towns",
        "units": 6,
        "city": "Portland",
        "laundry": true,
        "photo": "/assets/webaliser-_TPTXZd9mOo-unsplash.jpg",
        "rental": true,
        "state": "OR",
        "wifi": true
    }
]'

# Create a SQLite database and table
sqlite3 housing.db <<EOF
  CREATE TABLE IF NOT EXISTS houses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        units INTEGER,
        city TEXT,
        laundry INTEGER,
        photo TEXT,
        rental INTEGER,
        state TEXT,
        wifi INTEGER
  );
EOF

# Insert data into the table
echo "$json_data" | jq -c '.[]' | while read entry; do
    id=$(echo $entry | jq '.id')
    name=$(echo $entry | jq -r '.name')
    units=$(echo $entry | jq '.units')
    city=$(echo $entry | jq '.city')
    laundry=$(echo $entry | jq '.laundry')
    photo=$(echo $entry | jq '.photo')
    rental=$(echo $entry | jq '.rental')
    state=$(echo $entry | jq '.state')
    wifi=$(echo $entry | jq '.wifi')

    sqlite3 housing.db "INSERT INTO houses(name, units, city, laundry, photo, rental, state, wifi) VALUES ('$name', $units, '$city', $laundry, '$photo', $rental, '$state', $wifi);"
done

echo "Database and table created, and data inserted successfully."

