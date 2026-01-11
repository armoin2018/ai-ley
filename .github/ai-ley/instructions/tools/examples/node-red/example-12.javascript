// Switch node configuration
{
    "type": "switch",
    "name": "Route Messages",
    "property": "payload",
    "rules": [
        {
            "t": "gt",
            "v": "25",
            "vt": "num"
        },
        {
            "t": "between",
            "v": "15",
            "v2": "25",
            "vt": "num"
        },
        {
            "t": "else"
        }
    ]
}