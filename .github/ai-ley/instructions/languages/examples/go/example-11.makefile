# Makefile
.PHONY: test build lint format deps clean

deps:
	go mod download
	go mod verify

format:
	go fmt ./...
	goimports -w .

lint:
	golangci-lint run ./...

test:
	go test -v -race -cover ./...

test-short:
	go test -v -short ./...

build:
	go build -o bin/myapp ./cmd/myapp

clean:
	rm -rf bin/
	go clean -cache

docker-build:
	docker build -t myapp:latest .

generate:
	go generate ./...

.DEFAULT_GOAL := test