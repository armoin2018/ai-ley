class Game {
    constructor(canvas) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.lastTime = 0;
        this.gameObjects = [];
    }
    
    gameLoop(currentTime) {
        const deltaTime = currentTime - this.lastTime;
        this.update(deltaTime);
        this.render();
        this.lastTime = currentTime;
        requestAnimationFrame(this.gameLoop.bind(this));
    }
}