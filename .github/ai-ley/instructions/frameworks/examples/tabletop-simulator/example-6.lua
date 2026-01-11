function createPlayerUI()
    self.UI.setXmlTable({
        {
            tag = "Panel",
            attributes = { position = "0 0 -50", width = "300", height = "200" },
            children = {
                {
                    tag = "Button",
                    attributes = { 
                        onClick = "rollDice",
                        text = "Roll Dice",
                        fontSize = "18"
                    }
                },
                {
                    tag = "Text",
                    attributes = { 
                        id = "scoreDisplay",
                        text = "Score: 0",
                        fontSize = "16"
                    }
                }
            }
        }
    })
end