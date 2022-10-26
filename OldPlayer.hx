import hxd.Res;
import h2d.Tile;
import hxd.Key;

class OldPlayer extends h2d.Bitmap {
	public var missiles:Array<Missile> = [];
	public var score:Int = 0;

	var bounds:h2d.Bitmap;
	var sceneWidth:Int;
	var sceneHeight:Int;

	public function new(parent:h2d.Object, width, height, x, y, sceneWidth, sceneHeight) {
		Res.initEmbed();
		var tile = Res.player.stopped.base.toTile();
		tile.dx = -(width / 2);
		tile.dy = -(height / 2);

		super(tile, parent);

		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.sceneWidth = sceneWidth;
		this.sceneHeight = sceneHeight;

		this.createGraphicBounds(parent);
		this.setEvent(parent);
	}

	function handleMove() {
		if (Key.isPressed(Key.UP) || Key.isDown(Key.UP)) {
			this.move(2.5, 2.5);
			this.bounds.move(2.5, 2.5);
		}
		if (Key.isPressed(Key.DOWN) || Key.isDown(Key.DOWN)) {
			this.move(-2.5, -2.5);
			this.bounds.move(-2.5, -2.5);
		}
		if (Key.isPressed(Key.LEFT) || Key.isDown(Key.LEFT)) {
			this.rotate(-0.08);
			this.bounds.rotate(-0.08);
		}
		if (Key.isPressed(Key.RIGHT) || Key.isDown(Key.RIGHT)) {
			this.rotate(0.08);
			this.bounds.rotate(0.08);
		}
		if (Key.isPressed(Key.SPACE)) {
			this.fire();
		}
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

	public function fire() {
		this.missiles.push(new Missile(parent, this.x, this.y, this.rotation));
	}

	private function createGraphicBounds(parent:h2d.Object) {
		var bounds = this.getBounds();
		var tile = Tile.fromColor(0xCF2323, hxd.Math.floor(bounds.width), hxd.Math.floor(bounds.height));
		tile.dx = -(this.width / 2);
		tile.dy = -(this.height / 2);

		this.bounds = new h2d.Bitmap(tile, parent);
		this.bounds.x = this.x;
		this.bounds.y = this.y;
		this.bounds.alpha = 0;
		this.bounds.width = this.width;
		this.bounds.height = this.height;
		this.bounds.rotation = this.rotation;
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
