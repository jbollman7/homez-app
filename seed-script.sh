#!/bin/bash

# Define the JSON array
json_data='[
    {
        "id": 0,
        "name": "Acme Fresh Start Housing",
        "availableUnits": 4,
        "city": "Chicago",
        "laundry": true,
        "photo": "/assets/bernard-hermant-CLKGGwIBTaY-unsplash.jpg",
        "state": "IL",
        "wifi": true
    },
    {
        "id": 1,
        "name": "Sky High Housing",
        "availableUnits": 0,
        "city": "San Diego",
        "laundry": true,
        "photo": "/assets/brandon-griggs-wR11KBaB86U-unsplash.jpg",
        "state": "CA",
        "wifi": false
    },
    {
        "id": 2,
        "name": "Bed and Breakfast",
        "availableUnits": 1,
        "city": "Casper",
        "laundry": false,
        "photo": "/assets/i-do-nothing-but-love-lAyXdl1-Wmc-unsplash.jpg",
        "state": "WY",
        "wifi": false
    },
    {
        "id": 3,
        "name": "Suburban Housing",
        "availableUnits": 1,
        "city": "Chicago",
        "laundry": false,
        "photo": "/assets/ian-macdonald-W8z6aiwfi1E-unsplash.jpg",
        "state": "IL",
        "wifi": true
    },
    {
        "id": 4,
        "name": "Happy Homes Group",
        "availableUnits": 1,
        "city": "Salina",
        "laundry": false,
        "photo": "/assets/krzysztof-hepner-978RAXoXnH4-unsplash.jpg",
        "state": "KS",
        "wifi": true
    },
    {
        "id": 5,
        "name": "Hopeful Apartment Group",
        "availableUnits": 2,
        "city": "Kansas City",
        "laundry": true,
        "photo": "/assets/r-architecture-JvQ0Q5IkeMM-unsplash.jpg",
        "state": "KS",
        "wifi": true
    },
    {
        "id": 6,
        "name": "Seriously Safe Towns",
        "availableUnits": 5,
        "city": "Manhattan",
        "laundry": true,
        "photo": "/assets/phil-hearing-IYfp2Ixe9nM-unsplash.jpg",
        "state": "KS",
        "wifi": true
    },
    {
        "id": 7,
        "name": "Modern Homes",
        "availableUnits": 2,
        "city": "Lawrence",
        "laundry": true,
        "photo": "/assets/r-architecture-GGupkreKwxA-unsplash.jpg",
        "state": "KS",
        "wifi": true
    },
    {
        "id": 8,
        "name": "Condos & More",
        "availableUnits": 10,
        "city": "Atlanta",
        "laundry": false,
        "photo": "/assets/saru-robert-9rP3mxf8qWI-unsplash.jpg",
        "state": "GA",
        "wifi": false
    },
    {
        "id": 9,
        "name": "Capital Safe Towns",
        "availableUnits": 6,
        "city": "Portland",
        "laundry": true,
        "photo": "/assets/webaliser-_TPTXZd9mOo-unsplash.jpg",
        "state": "OR",
        "wifi": true
    }
]'

# Create a SQLite database and table
sqlite3 housing.db <<EOF
  CREATE TABLE IF NOT EXISTS house_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        availableUnits INTEGER,
        city TEXT,
        laundry INTEGER,
        photo TEXT,
        state TEXT,
        wifi INTEGER
  );
EOF

# Insert data into the table
echo "$json_data" | jq -c '.[]' | while read entry; do
    id=$(echo $entry | jq '.id')
    name=$(echo $entry | jq -r '.name')
    availableUnits=$(echo $entry | jq '.availableUnits')
    city=$(echo $entry | jq '.city')
    laundry=$(echo $entry | jq '.laundry')
    photo=$(echo $entry | jq '.photo')
    state=$(echo $entry | jq '.state')
    wifi=$(echo $entry | jq '.wifi')

    sqlite3 housing.db "INSERT INTO house_table(name, availableUnits, city, laundry, photo, state, wifi) VALUES ('$name', $availableUnits, '$city', $laundry, '$photo', '$state', $wifi);"
done

echo "Database and table created, and data inserted successfully."

