import h2d.Bitmap;
import h2d.Tile;

class Missile extends h2d.Bitmap {
	public function new(parent:h2d.Object, x, y, angle) {
		var tile = Tile.fromColor(0x23cf4e, 10, 5);
		super(tile, parent);

		this.x = x;
		this.y = y;
		this.rotation = angle;
	}

	public function deplacement() {
		this.move(4, 4);
	}
}
