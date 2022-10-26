import h2d.col.Bounds;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Anim;
import hxd.Res;
import hxd.Key;

class Player extends Anim {
	public var missiles:Array<Missile> = [];
	public var score:Int = 0;

	var tiles:Array<h2d.Tile> = [];
	var direction:String;
	var bounds:h2d.Bitmap;
	var sceneWidth:Int;
	var sceneHeight:Int;

	public function new(parent:h2d.Object, sceneWidth, sceneHeight) {
		Res.initEmbed();
		this.tiles.push(Res.player.stopped.base.toTile());

		for (tile in this.tiles) {
			tile.scaleToSize(50, 50);
			tile.dx = -(50 / 2);
			tile.dy = -(50 / 2);
		}

		super(tiles, 7, parent);

		this.x = 300;
		this.y = 300;
		this.sceneWidth = sceneWidth;
		this.sceneHeight = sceneHeight;

		this.createVisualBounds();
		this.handleHitbox();
		this.setEvent();
	}

	function handleMove() {
		if (Key.isPressed(Key.UP) || Key.isDown(Key.UP)) {
			if (this.direction != 'up') {
				this.tiles = [];

				this.tiles.push(Res.player.movement.base_1.toTile());
				this.tiles.push(Res.player.movement.base_2.toTile());

				for (tile in this.tiles) {
					tile.scaleToSize(50, 50);
					tile.dx = -(50 / 2);
					tile.dy = -(50 / 2);
				}

				this.play(this.tiles, 0);
				this.direction = 'up';
			}

			this.move(2.5, 2.5);
		}
		if (Key.isPressed(Key.DOWN) || Key.isDown(Key.DOWN)) {
			if (this.direction != 'down') {
				this.tiles = [];

				this.tiles.push(Res.player.movement.base_1.toTile());
				this.tiles.push(Res.player.movement.base_2.toTile());

				for (tile in this.tiles) {
					tile.scaleToSize(50, 50);
					tile.dx = -(50 / 2);
					tile.dy = -(50 / 2);
				}

				this.play(this.tiles, 0);
				this.direction = 'down';
			}

			this.move(-2.5, -2.5);
		}
		if (Key.isPressed(Key.LEFT) || Key.isDown(Key.LEFT)) {
			if (this.direction != 'left') {
				this.tiles = [];

				this.tiles.push(Res.player.movement.left_1.toTile());
				this.tiles.push(Res.player.movement.left_2.toTile());
				this.tiles.push(Res.player.movement.left_3.toTile());

				for (tile in this.tiles) {
					tile.scaleToSize(50, 50);
					tile.dx = -(50 / 2);
					tile.dy = -(50 / 2);
				}

				this.play(this.tiles, 0);
				this.loop = false;
				this.direction = 'left';
			}

			this.rotate(-0.08);
		}
		if (Key.isPressed(Key.RIGHT) || Key.isDown(Key.RIGHT)) {
			if (this.direction != 'right') {
				this.tiles = [];

				this.tiles.push(Res.player.movement.right_1.toTile());
				this.tiles.push(Res.player.movement.right_2.toTile());
				this.tiles.push(Res.player.movement.right_3.toTile());

				for (tile in this.tiles) {
					tile.scaleToSize(50, 50);
					tile.dx = -(50 / 2);
					tile.dy = -(50 / 2);
				}

				this.play(this.tiles, 0);
				this.loop = false;
				this.direction = 'right';
			}
			this.rotate(0.08);
		}
		if (Key.isPressed(Key.SPACE)) {
			this.fire();
		}

		if (!(Key.isPressed(Key.UP) || Key.isDown(Key.UP))
			&& !(Key.isPressed(Key.DOWN) || Key.isDown(Key.DOWN))
			&& !(Key.isPressed(Key.LEFT) || Key.isDown(Key.LEFT))
			&& !(Key.isPressed(Key.RIGHT) || Key.isDown(Key.RIGHT))) {
			this.tiles = [];
			this.tiles.push(Res.player.stopped.base.toTile());

			for (tile in this.tiles) {
				tile.scaleToSize(50, 50);
				tile.dx = -(50 / 2);
				tile.dy = -(50 / 2);
			}

			this.play(this.tiles);
			this.direction = 'base';
		}
	}

	public function fire() {
		this.missiles.push(new Missile(parent, this.x, this.y, this.rotation));
	}

	public function handleHitbox() {
		var hitbox = new Bounds();
		hitbox.x = this.x;
		hitbox.y = this.y;
		hitbox.width = 50;
		hitbox.height = 50 - 30;

		return hitbox;
	}

	private function createVisualBounds() {
		var bounds = this.handleHitbox();
		var tile = Tile.fromColor(0xCF2323, hxd.Math.floor(bounds.width), hxd.Math.floor(bounds.height));

		this.bounds = new h2d.Bitmap(tile, this);
		this.bounds.x = -25;
		this.bounds.y = -10;
		this.bounds.alpha = 0;
	}

	private function setEvent() {
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

	public function update(dt) {
		this.handleMove();

		if (this.missiles.length > 0) {
			for (missile in this.missiles) {
				if (missile.x > this.sceneWidth || missile.y > this.sceneHeight || missile.x < 0 || missile.y < 0) {
					var index = this.missiles.indexOf(missile);
					this.missiles.splice(index, 1);
					missile.remove();
				} else {
					missile.deplacement();
				}
			}
		}
	}
}
