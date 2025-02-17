package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	_ "github.com/mattn/go-sqlite3" // Import go-sqlite3 library
)

type listing struct {
	ID      int32  `json:"id"`
	Name    string `json:"name"`
	Units   int32  `json:"units"`
	City    string `json:"city"`
	Laundry bool   `json:"laundry"`
	Photo   string `json:"photo"`
	Rental  bool   `json:"rental"`
	State   string `json:"state"`
	Wifi    bool   `json:"wifi"`
}

// var listings = []listing{
// 	{
// 		ID:      8,
// 		Name:    "Condos & More",
// 		Units:   10,
// 		City:    "Atlanta",
// 		Laundry: false,
// 		Photo:   "/assets/saru-robert-9rP3mxf8qWI-unsplash.jpg",
// 		Rental:  false,
// 		State:   "GA",
// 		Wifi:    false,
// 	},
// 	{
// 		ID:      9,
// 		Name:    "Capital Safe Towns",
// 		Units:   6,
// 		City:    "Portland",
// 		Laundry: true,
// 		Photo:   "/assets/webaliser-_TPTXZd9mOo-unsplash.jpg",
// 		Rental:  true,
// 		State:   "OR",
// 		Wifi:    true,
// 	},
// }

// Database key for Gin context
const dbKey = "db"

// Middleware to set up the database connection
func dbMiddleware(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Set(dbKey, db)
		c.Next()
	}
}

func startServer(db *sql.DB) {
	router := gin.Default()

	// Use the dbMiddleware to set up the database connection
	router.Use(dbMiddleware(db))

	router.GET("/listings", getAllListings)
	router.GET("/listings/:id", getListingByID)

	router.Run("localhost:8080")
}

// getlistings responds with the list of all listings
// API ENDPOINT
func getAllListings(c *gin.Context) {
	listings, err := getAllListingsFromDB(c)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, listings)

}

// Get specific record Endpont
func getListingByID(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}

	listing, err := getSpecificListingFromDB(c, int32(id))
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	if listing == nil {
		c.AbortWithStatus(http.StatusNotFound)
		return
	}

	c.JSON(http.StatusOK, listing)
}

// getListings retrieves listings from the database
func getAllListingsFromDB(c *gin.Context) ([]listing, error) {
	db, exists := c.Get(dbKey)
	if !exists {
		return nil, fmt.Errorf("database connection not found")
	}

	rows, err := db.(*sql.DB).Query("SELECT id, name, units, city, laundry, photo, rental, state, wifi FROM houses")

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var listings []listing
	for rows.Next() {
		var listing listing
		if err := rows.Scan(&listing.ID, &listing.Name, &listing.Units, &listing.City, &listing.Laundry, &listing.Photo, &listing.Rental, &listing.State, &listing.Wifi); err != nil {
			return nil, err
		}
		listings = append(listings, listing)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return listings, nil
}

func getSpecificListingFromDB(c *gin.Context, id int32) (*listing, error) {
	db, exists := c.Get(dbKey)
	if !exists {
		return nil, fmt.Errorf("database connection not found")
	}

	sqlDB, ok := db.(*sql.DB)
	if !ok {
		return nil, fmt.Errorf("invalid database connection type")
	}

	row := sqlDB.QueryRow("SELECT id, name, units, city, laundry, photo, rental, state, wifi FROM houses WHERE id = ?", id)

	var listing listing
	err := row.Scan(&listing.ID, &listing.Name, &listing.Units, &listing.City, &listing.Laundry, &listing.Photo, &listing.Rental, &listing.State, &listing.Wifi)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil // No matching row found
		}
		return nil, err
	}

	return &listing, nil
}

func main() {

	// Connect to db
	db, err := sql.Open("sqlite3", "../housing.db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	startServer(db)

}
