extends Node
signal finished_text

var bg: ColorRect
const KEYBOARD_KEYS: Dictionary[int, String] = {
	KEY_Q: "q",
	KEY_W: "w",
	KEY_E: "e",
	KEY_R: "r",
	KEY_T: "t",
	KEY_Y: "y",
	KEY_U: "u",
	KEY_I: "i",
	KEY_O: "o",
	KEY_P: "p",
	KEY_A: "a",
	KEY_S: "s",
	KEY_D: "d",
	KEY_F: "f",
	KEY_G: "g",
	KEY_H: "h",
	KEY_J: "j",
	KEY_K: "k",
	KEY_L: "l",
	KEY_Z: "z",
	KEY_X: "x",
	KEY_C: "c",
	KEY_V: "v",
	KEY_B: "b",
	KEY_N: "n",
	KEY_M: "m",
	KEY_0: "0",
	KEY_1: "1",
	KEY_2: "2",
	KEY_3: "3",
	KEY_4: "4",
	KEY_5: "5",
	KEY_6: "6",
	KEY_7: "7",
	KEY_8: "8",
	KEY_9: "9"
}
const CONTROLLER_INPUTS: Dictionary[int, int] = {
	JOY_BUTTON_A: 0,
	JOY_BUTTON_B: 1,
	JOY_BUTTON_X: 2,
	JOY_BUTTON_Y: 3,
	JOY_BUTTON_LEFT_SHOULDER: 4,
	JOY_BUTTON_RIGHT_SHOULDER: 5,
	JOY_BUTTON_PADDLE1: 6,
	JOY_BUTTON_PADDLE2: 7,
	JOY_BUTTON_PADDLE3: 8,
	JOY_BUTTON_PADDLE4: 9
}
var CONTROLLER_CONNECTED := Input.get_connected_joypads().size() != 0
