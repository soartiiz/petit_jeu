import hxd.Key;

class HeroExample extends CharacterExample {
    
    override function init() {
        this.setEvent();
        super.init();
    }

    function setEvent () {
        hxd.Window.getInstance().addEventTarget(function onEvent(event : hxd.Event) {
            if (event.kind == EKeyDown) {
                if (event.keyCode == Key.DOWN)
                    this.y += 10;
                if (event.keyCode == Key.UP)
                    this.y -= 10;
                if (event.keyCode == Key.LEFT)
                    this.x -= 10;
                if (event.keyCode == Key.RIGHT)
                    this.x += 10;
            }
        });
    }
}