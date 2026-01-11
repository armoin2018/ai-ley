// High-performance TCP socket configuration
int sock = socket(AF_INET, SOCK_STREAM, 0);

// Enable TCP_NODELAY for low latency
int flag = 1;
setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &flag, sizeof(flag));

// Optimize send/receive buffers
int bufsize = 1048576; // 1MB
setsockopt(sock, SOL_SOCKET, SO_SNDBUF, &bufsize, sizeof(bufsize));
setsockopt(sock, SOL_SOCKET, SO_RCVBUF, &bufsize, sizeof(bufsize));

// Enable timestamp options for RTT measurement
int timestamps = 1;
setsockopt(sock, IPPROTO_TCP, TCP_TIMESTAMP, &timestamps, sizeof(timestamps));