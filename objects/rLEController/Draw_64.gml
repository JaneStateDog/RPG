//Draw controls
draw_set_font(fMain);
var drawY = 1;

if (overlay) {
	draw_text(16, drawY * 16, "Move camera: Middle click and drag");
	drawY++;
	draw_text(16, drawY * 16, "Make camera follow player: Control + alt + middle click");
	drawY++;
	
	drawY++;
	draw_text(16, drawY * 16, "Save: Control + S");
	drawY++;
	draw_text(16, drawY * 16, "Load: Control + L");
	drawY++;

	drawY++;
	draw_text(16, drawY * 16, "Place wall: Left click");
	drawY++;
	draw_text(16, drawY * 16, "Place one way: Alt + left click");
	drawY++;
	draw_text(16, drawY * 16, "Place exit: E + left click");
	drawY++;
	draw_text(16, drawY * 16, "Place attack: Q + left click");
	drawY++;
	draw_text(16, drawY * 16, "Place spikes: T + left click");
	drawY++;

	drawY++;
	draw_text(16, drawY * 16, "Remove block or one way: Right click");
	drawY++;
	draw_text(16, drawY * 16, "Rotate block: R");
	drawY++;

	drawY++;
	draw_text(16, drawY * 16, "Place player: Control + left click");
	drawY++;
	
	
	drawY++;
	draw_text(16, drawY * 16, "Toggle overlay: Control + alt + O");
}