// user.proto compiled to user.pb.go
package main

import (
    "context"
    "database/sql"
    "fmt"
    "log"
    "net"
    "time"

    "google.golang.org/grpc"
    "google.golang.org/grpc/codes"
    "google.golang.org/grpc/metadata"
    "google.golang.org/grpc/status"
    pb "myapp/proto/user" // Generated from protobuf
)

type server struct {
    pb.UnimplementedUserServiceServer
    db *sql.DB
}

func (s *server) GetUser(ctx context.Context, req *pb.GetUserRequest) (*pb.User, error) {
    if req.Id <= 0 {
        return nil, status.Error(codes.InvalidArgument, "user ID must be positive")
    }
    
    var user pb.User
    err := s.db.QueryRowContext(ctx,
        "SELECT id, name, email FROM users WHERE id = $1",
        req.Id).Scan(&user.Id, &user.Name, &user.Email)
    
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, status.Error(codes.NotFound, "user not found")
        }
        log.Printf("Database error: %v", err)
        return nil, status.Error(codes.Internal, "internal server error")
    }
    
    return &user, nil
}

func (s *server) CreateUser(ctx context.Context, req *pb.CreateUserRequest) (*pb.User, error) {
    if req.Name == "" || req.Email == "" {
        return nil, status.Error(codes.InvalidArgument, "name and email are required")
    }
    
    var user pb.User
    err := s.db.QueryRowContext(ctx,
        "INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id, name, email",
        req.Name, req.Email).Scan(&user.Id, &user.Name, &user.Email)
    
    if err != nil {
        log.Printf("Database error: %v", err)
        return nil, status.Error(codes.Internal, "internal server error")
    }
    
    return &user, nil
}

// Logging interceptor
func loggingInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
    start := time.Now()
    
    resp, err := handler(ctx, req)
    
    duration := time.Since(start)
    log.Printf("Method: %s, Duration: %v, Error: %v", info.FullMethod, duration, err)
    
    return resp, err
}

// Timeout interceptor
func timeoutInterceptor(timeout time.Duration) grpc.UnaryServerInterceptor {
    return func(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
        ctx, cancel := context.WithTimeout(ctx, timeout)
        defer cancel()
        
        return handler(ctx, req)
    }
}

func main() {
    db, err := sql.Open("postgres", "postgresql://localhost/myapp?sslmode=disable")
    if err != nil {
        log.Fatal("Failed to connect to database:", err)
    }
    defer db.Close()
    
    lis, err := net.Listen("tcp", ":50051")
    if err != nil {
        log.Fatalf("Failed to listen: %v", err)
    }
    
    s := grpc.NewServer(
        grpc.ChainUnaryInterceptor(
            loggingInterceptor,
            timeoutInterceptor(10*time.Second),
        ),
    )
    
    pb.RegisterUserServiceServer(s, &server{db: db})
    
    log.Println("gRPC server starting on :50051")
    if err := s.Serve(lis); err != nil {
        log.Fatalf("Failed to serve: %v", err)
    }
}