// HTTP Request node for API calls
{
    "type": "http request",
    "name": "Weather API",
    "method": "GET",
    "ret": "obj",
    "url": "https://api.openweathermap.org/data/2.5/weather",
    "tls": "",
    "persist": false,
    "proxy": "",
    "authType": "",
    "headers": {
        "User-Agent": "Node-RED"
    }
}

// Function node to prepare API request
msg.url = `https://api.openweathermap.org/data/2.5/weather?q=${msg.payload.city}&appid=${env.get('WEATHER_API_KEY')}`;
return msg;