// Inject node configuration
{
    "type": "inject",
    "name": "Timer",
    "props": [
        {
            "p": "payload",
            "v": "Hello World",
            "vt": "str"
        },
        {
            "p": "topic",
            "v": "test/topic",
            "vt": "str"
        }
    ],
    "repeat": "5",  // Every 5 seconds
    "crontab": "",
    "once": false
}