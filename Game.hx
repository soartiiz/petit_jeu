import h2d.Bitmap;
import h2d.Tile;
import h2d.Text;
import hxd.res.DefaultFont;
import hxd.Res;

class Game extends hxd.App {
	public static var I:Game;

	var player:Player;
	// var player:OldPlayer;
	var playerScore:Text;
	var font:h2d.Font;
	var asteroids:Array<Asteroid> = [];
	var missiles:Array<Missile> = [];
	var gameOverText:h2d.Text;
	var isGameOver:Bool = false;
	var time:Int = 0;
	var saveTime:Int = 200;

	static function main() {
		I = new Game();
	}

	override function init() {
		this.font = DefaultFont.get();
		Res.initEmbed();

		var background = Res.background.toTile();
		new Bitmap(background, s2d);

		var button = new CustomButton(s2d, 300, 300, 'Jouer');
		button.interaction.onClick = function(event:hxd.Event) {
			this.startGame();
			button.remove();
		}
	}

	override function update(dt) {
		if (this.player != null && !this.isGameOver) {
			this.player.update(dt);
			this.playerScore.text = Std.string("Score: " + this.player.score);
			this.handleHitbox();
			this.generateAsteroids();
		}
	}

	private function startGame() {
		if (this.asteroids.length > 0) {
			for (asteroid in this.asteroids) {
				asteroid.remove();
			}
		}

		if (this.player != null) {
			if (this.player.missiles.length > 0) {
				for (missile in this.player.missiles) {
					missile.remove();
				}
			}
		}

		this.gameOverText.remove();
		this.player.remove();
		this.asteroids = [];
		this.playerScore.remove();

		// this.player = new OldPlayer(s2d, 50, 50, 300, 300, s2d.width, s2d.height);
		this.player = new Player(s2d, s2d.width, s2d.height);
		this.playerScore = new Text(this.font, s2d);
		this.playerScore.scale(2);
		this.playerScore.x = this.s2d.width - 150;
		this.playerScore.y = this.s2d.height - 50;

		this.asteroids.push(new Asteroid(s2d, 100, 100, 0, 0));
		this.asteroids.push(new Asteroid(s2d, 100, 100, s2d.width, 0));
		this.asteroids.push(new Asteroid(s2d, 100, 100, 0, s2d.height));

		this.isGameOver = false;
	}

	private function generateAsteroids() {
		this.time += 1;

		if (this.saveTime < this.time) {
			this.saveTime += 150;
			var randomSide = Math.floor(Math.random() * Math.floor(4));

			switch (randomSide) {
				case 0:
					this.asteroids.push(new Asteroid(s2d, 100, 100, Math.floor(Math.random() * Math.floor(s2d.width)), 0));
				case 1:
					this.asteroids.push(new Asteroid(s2d, 100, 100, 0, Math.floor(Math.random() * Math.floor(s2d.height))));
				case 2:
					this.asteroids.push(new Asteroid(s2d, 100, 100, Math.floor(Math.random() * Math.floor(s2d.width)), s2d.height));
				case 3:
					this.asteroids.push(new Asteroid(s2d, 100, 100, s2d.width, Math.floor(Math.random() * Math.floor(s2d.height))));
			}
		}
	}

	private function handleHitbox() {
		var playerHitbox = this.player.handleHitbox();

		var index = -1;

		// HITBOX ENTRE JOUEUR ET ASTEROIDS
		for (asteroid in this.asteroids) {
			if (!this.isGameOver) {
				index += 1;
				var asteroidHitbox = asteroid.getBounds();
				var contactPlayerAsteroid = playerHitbox.intersects(asteroidHitbox);
				// asteroid.chasePlayer(this.player.x, this.player.y, contactPlayerAsteroid);

				// GAME OVER
				if (contactPlayerAsteroid) {
					this.isGameOver = true;
					this.gameOver();
				}

				// HITBOX ENTRE ASTEROIDS ET MISSILES
				if (!this.isGameOver) {
					for (missile in this.player.missiles) {
						if (asteroidHitbox.intersects(missile.getBounds())) {
							this.player.score += 25;
							asteroid.remove();
							asteroid = null;
							this.asteroids.splice(index, 1);
						}
					}
				}
			}
		}
	}

	private function gameOver() {
		this.gameOverText = new Text(this.font, s2d);
		this.gameOverText.text = 'GAME OVER';
		this.gameOverText.scale(10);

		this.gameOverText.x = (this.s2d.width / 2) - 310;
		this.gameOverText.y = (this.s2d.height / 2) - 100;
		this.playerScore.scale(1.5);
		this.playerScore.x = (this.s2d.width / 2) - 75;
		this.playerScore.y = (this.s2d.height / 2) + 60;

		var button = new CustomButton(s2d, (s2d.width / 2) - 50, (s2d.height / 2) + 120, 'Rejouer');
		button.interaction.onClick = function(event:hxd.Event) {
			this.startGame();
			button.remove();
		}
	}
}
