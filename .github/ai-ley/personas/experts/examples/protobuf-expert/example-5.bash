#!/bin/bash
# High-performance protobuf compilation script

# Optimize for speed and minimal binary size
protoc \
  --cpp_out=./generated/cpp \
  --go_out=./generated/go \
  --python_out=./generated/python \
  --java_out=./generated/java \
  --csharp_out=./generated/csharp \
  --grpc_out=./generated \
  --plugin=protoc-gen-grpc=/usr/local/bin/grpc_cpp_plugin \
  --optimize_for=SPEED \
  --proto_path=./proto \
  ./proto/trading.proto

# Generate language-specific optimizations
# C++ with arena allocation for high-performance scenarios
protoc \
  --cpp_out=./generated/cpp \
  --cpp_opt=arena \
  --proto_path=./proto \
  ./proto/trading.proto

# Go with optimized imports
protoc \
  --go_out=./generated/go \
  --go_opt=paths=source_relative \
  --go_opt=Mproto/trading.proto=./trading \
  --proto_path=./proto \
  ./proto/trading.proto