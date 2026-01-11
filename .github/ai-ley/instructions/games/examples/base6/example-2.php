// Backend: Game Rule System
class Base6GameRule {
    public $connection_types;    // Valid card connections
    public $win_conditions;      // How to win the game
    public $turn_structure;      // Player action sequence
    public $scoring_system;      // Point calculation
    public $special_actions;     // Unique card abilities
}

// Frontend: Game Engine
class Base6GameEngine {
    public $card_deck;          // Available cards
    public $game_state;         // Current board/hand state
    public $player_data;        // Scores, turns, resources
    public $rule_validator;     // Move legality checker
    public $ai_opponent;        // Computer player (optional)
}