class GameScene extends Phaser.Scene {
    constructor() {
        super({ key: 'GameScene' });
    }
    
    preload() {
        // Asset loading
    }
    
    create() {
        // Game object creation
        this.physics.world.setBounds(0, 0, 800, 600);
    }
    
    update(time, delta) {
        // Game loop logic
    }
}