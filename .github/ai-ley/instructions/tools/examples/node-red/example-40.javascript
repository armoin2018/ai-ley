// settings.js logging configuration
logging: {
    console: {
        level: "debug",
        metrics: true,
        audit: true
    },
    file: {
        level: "info",
        filename: "/var/log/node-red/node-red.log",
        maxFiles: 5,
        maxSize: "10MB"
    }
}