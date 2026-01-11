// ✅ Well-designed struct with composition
type Server struct {
    config     Config
    router     *gin.Engine
    db         *sql.DB
    logger     Logger
    middleware []gin.HandlerFunc
    
    // Embed for composition
    *http.Server
}

func NewServer(config Config, db *sql.DB, logger Logger) *Server {
    s := &Server{
        config: config,
        db:     db,
        logger: logger,
        router: gin.New(),
    }
    
    s.Server = &http.Server{
        Addr:         config.Address,
        Handler:      s.router,
        ReadTimeout:  config.ReadTimeout,
        WriteTimeout: config.WriteTimeout,
    }
    
    s.setupRoutes()
    return s
}

// ✅ Receiver methods
func (s *Server) Start(ctx context.Context) error {
    s.logger.Info("starting server", "address", s.config.Address)
    
    errCh := make(chan error, 1)
    go func() {
        if err := s.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            errCh <- err
        }
    }()
    
    select {
    case err := <-errCh:
        return fmt.Errorf("server failed to start: %w", err)
    case <-ctx.Done():
        return s.Shutdown(context.Background())
    }
}