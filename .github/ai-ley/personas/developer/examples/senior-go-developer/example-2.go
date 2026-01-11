package main

import (
    "context"
    "fmt"
    "sync"
    "time"
)

type Job struct {
    ID   int
    Data string
}

type Result struct {
    Job    Job
    Output string
    Error  error
}

type WorkerPool struct {
    workerCount int
    jobs        chan Job
    results     chan Result
    done        chan struct{}
    wg          sync.WaitGroup
}

func NewWorkerPool(workerCount, bufferSize int) *WorkerPool {
    return &WorkerPool{
        workerCount: workerCount,
        jobs:        make(chan Job, bufferSize),
        results:     make(chan Result, bufferSize),
        done:        make(chan struct{}),
    }
}

func (wp *WorkerPool) Start(ctx context.Context) {
    // Start workers
    for i := 0; i < wp.workerCount; i++ {
        wp.wg.Add(1)
        go wp.worker(ctx, i)
    }
    
    // Start result collector
    go wp.collectResults()
}

func (wp *WorkerPool) worker(ctx context.Context, id int) {
    defer wp.wg.Done()
    
    for {
        select {
        case job, ok := <-wp.jobs:
            if !ok {
                fmt.Printf("Worker %d: shutting down\n", id)
                return
            }
            
            fmt.Printf("Worker %d: processing job %d\n", id, job.ID)
            result := wp.processJob(ctx, job)
            
            select {
            case wp.results <- result:
            case <-ctx.Done():
                fmt.Printf("Worker %d: context cancelled\n", id)
                return
            }
            
        case <-ctx.Done():
            fmt.Printf("Worker %d: context cancelled\n", id)
            return
        }
    }
}

func (wp *WorkerPool) processJob(ctx context.Context, job Job) Result {
    // Simulate work with timeout
    workCtx, cancel := context.WithTimeout(ctx, 2*time.Second)
    defer cancel()
    
    select {
    case <-time.After(100 * time.Millisecond): // Simulate processing time
        return Result{
            Job:    job,
            Output: fmt.Sprintf("Processed: %s", job.Data),
            Error:  nil,
        }
    case <-workCtx.Done():
        return Result{
            Job:    job,
            Output: "",
            Error:  workCtx.Err(),
        }
    }
}

func (wp *WorkerPool) collectResults() {
    for result := range wp.results {
        if result.Error != nil {
            fmt.Printf("Job %d failed: %v\n", result.Job.ID, result.Error)
        } else {
            fmt.Printf("Job %d completed: %s\n", result.Job.ID, result.Output)
        }
    }
    close(wp.done)
}

func (wp *WorkerPool) Submit(job Job) bool {
    select {
    case wp.jobs <- job:
        return true
    default:
        return false // Job queue full
    }
}

func (wp *WorkerPool) Shutdown() {
    close(wp.jobs)
    wp.wg.Wait()
    close(wp.results)
    <-wp.done
}

func main() {
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    
    pool := NewWorkerPool(3, 10)
    pool.Start(ctx)
    
    // Submit jobs
    for i := 0; i < 20; i++ {
        job := Job{
            ID:   i,
            Data: fmt.Sprintf("data-%d", i),
        }
        
        if !pool.Submit(job) {
            fmt.Printf("Failed to submit job %d: queue full\n", i)
        }
    }
    
    // Wait a bit then shutdown
    time.Sleep(3 * time.Second)
    pool.Shutdown()
    fmt.Println("All jobs completed")
}