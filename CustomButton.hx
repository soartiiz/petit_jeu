import h2d.Graphics;
import h2d.Text;
import hxd.res.DefaultFont;

class CustomButton extends h2d.Graphics {
	public var interaction:h2d.Interactive;
	public var width:Int;
	public var height:Int;

	var text:h2d.Text;

	public function new(parent, x, y, text) {
		super(parent);

		var font = DefaultFont.get();
		this.text = new h2d.Text(font, this);
		this.text.text = text;
		this.text.scale(1);

		this.width = Math.floor(this.text.textWidth + 50);
		this.height = 40;

		this.beginFill(0xCF2323);
		this.drawRect(x, y, this.width, this.height);
		this.endFill();

		this.text.x = x + 25;
		this.text.y = y + 11;

		this.interaction = new h2d.Interactive(this.width, this.height, this);
		this.interaction.x = x;
		this.interaction.y = y;
	}
}
