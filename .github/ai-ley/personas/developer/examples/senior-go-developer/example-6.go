package main

import (
    "context"
    "database/sql"
    "net/http"
    "net/http/httptest"
    "strings"
    "testing"
    "time"

    "github.com/jmoiron/sqlx"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/require"
    _ "github.com/lib/pq"
)

func TestServer_GetUser(t *testing.T) {
    db := setupTestDB(t)
    defer db.Close()
    
    server := NewServer(db)
    
    // Insert test data
    _, err := db.Exec("INSERT INTO users (id, name, email) VALUES ($1, $2, $3)",
        1, "John Doe", "john@example.com")
    require.NoError(t, err)
    
    req := httptest.NewRequest("GET", "/users/1", nil)
    w := httptest.NewRecorder()
    
    server.router.ServeHTTP(w, req)
    
    assert.Equal(t, http.StatusOK, w.Code)
    assert.Contains(t, w.Body.String(), "John Doe")
}

func setupTestDB(t *testing.T) *sqlx.DB {
    db, err := sqlx.Connect("postgres", "postgresql://localhost/test_db?sslmode=disable")
    require.NoError(t, err)
    
    // Create tables and seed data
    _, err = db.Exec(`
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) NOT NULL
        )
    `)
    require.NoError(t, err)
    
    return db
}