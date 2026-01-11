// Change node operations
{
    "type": "change",
    "name": "Transform Data",
    "rules": [
        {
            "t": "set",
            "p": "payload.temperature",
            "pt": "msg",
            "to": "payload",
            "tot": "msg"
        },
        {
            "t": "move",
            "p": "payload.old_name",
            "pt": "msg",
            "to": "payload.new_name",
            "tot": "msg"
        },
        {
            "t": "delete",
            "p": "payload.unwanted",
            "pt": "msg"
        }
    ]
}