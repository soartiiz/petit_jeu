import h2d.col.Bounds;
import h2d.Tile;

class CharacterExample extends h2d.Bitmap {
    public var characterName: String = 'ND';
    var displayName: h2d.Text;

    public function new (parent: h2d.Object, width: Int, height: Int, color: Int, ?x: Float, ?y: Float) {
        var tile = Tile.fromColor(color, width, height);
        super(tile, parent);

        this.x = x;
        this.y = y;

        /* var font : h2d.Font = hxd.res.DefaultFont.get();
        this.displayName = new h2d.Text(font, this);
        this.displayName.x = 10 + width; */

        this.init();
    }

    public function getHitbox () {
        var hitBox = new Bounds();
        hitBox.xMin = this.x;
        hitBox.yMin = this.y;
        hitBox.xMax = this.x + 10;
        hitBox.yMax = this.y + 10;

        return hitBox;
    }

    function init() {
        trace('INITIALISÉE');
    };

    public function update(dt) {        
        // this.displayName.text = this.characterName;
    }
}