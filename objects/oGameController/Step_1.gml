//Get the keys
keyLeft = (keyboard_check(ord("A")) or keyboard_check(vk_left));
keyLeftPressed = (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left));

keyRight = (keyboard_check(ord("D")) or keyboard_check(vk_right));
keyRightPressed = (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right));

keyUp = (keyboard_check(ord("W")) or keyboard_check(vk_up));
keyUpPressed = (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up));

keyDown = (keyboard_check(ord("S")) or keyboard_check(vk_down));
keyDownPressed = (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down));


keySpacePressed = keyboard_check_pressed(vk_space);
keyEscapePressed = keyboard_check_pressed(vk_escape);

keySPressed = keyboard_check_pressed(ord("S"));
keyLPressed = keyboard_check_pressed(ord("L"));
keyRPressed = keyboard_check_pressed(ord("R"));
keyOPressed = keyboard_check_pressed(ord("O"));

keyE = keyboard_check(ord("E"));
keyQ = keyboard_check(ord("Q"));
keyT = keyboard_check(ord("T"));

keyCtrl = keyboard_check(vk_control);
keyAlt = keyboard_check(vk_alt);


mouseLeft = mouse_check_button(mb_left);
mouseRight = mouse_check_button(mb_right);

mouseMiddle = mouse_check_button(mb_middle);
mouseMiddlePressed = mouse_check_button_pressed(mb_middle);