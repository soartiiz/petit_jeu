import h2d.Tile;
import h2d.Bitmap;
import h2d.col.Bounds;
import hxd.Key;
import h2d.Graphics;
import hxd.Res;

class Asteroid extends h2d.Bitmap {
	public var id:Int;
	// public var bounds:Graphics;
	public var bounds:Bitmap;

	public function new(parent:h2d.Object, width, height, x, y, ?color = 0xCF2323) {
		this.id = Math.floor(Math.random() * Math.floor(1000));
		var randomNumber = Math.floor(Math.random() * Math.floor(4));

		Res.initEmbed();
		var tile = Res.asteroids.asteroid_1.toTile();

		switch (randomNumber) {
			case 0:
				tile = Res.asteroids.asteroid_1.toTile();
			case 1:
				tile = Res.asteroids.asteroid_2.toTile();
			case 2:
				tile = Res.asteroids.asteroid_3.toTile();
			case 3:
				tile = Res.asteroids.asteroid_4.toTile();
		}

		super(tile, parent);

		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;

		this.createVisualBounds();
		this.setEvent(parent);
	}

	public function handleHitbox() {
		var hitbox = new Bounds();
		hitbox.x = this.x;
		hitbox.y = this.y;
		hitbox.width = this.width;
		hitbox.height = this.height;

		return hitbox;
	}

	private function createVisualBounds() {
		var bounds = this.handleHitbox();
		var tile = Tile.fromColor(0xCF2323, hxd.Math.floor(bounds.width), hxd.Math.floor(bounds.height));

		this.bounds = new h2d.Bitmap(tile, this);
		this.bounds.alpha = 0;
	}

	public function chasePlayer(playerX, playerY, contact) {
		if (!contact) {
			if (this.x != playerX) {
				if (this.x < playerX) {
					this.x += 1;
				} else {
					this.x -= 1;
				}
			}

			if (this.y != playerY) {
				if (this.y < playerY) {
					this.y += 1;
				} else {
					this.y -= 1;
				}
			}
		}
	}

	private function setEvent(parent) {
		hxd.Window.getInstance().addEventTarget(function onEvent(event:hxd.Event) {
			if (event.kind == EKeyDown) {
				if (event.keyCode == Key.Y) {
					if (this.bounds.alpha == 0) {
						this.bounds.alpha = 0.5;
					} else {
						this.bounds.alpha = 0;
					}
				}
			}
		});
	}
}
