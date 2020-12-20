//Randomize
randomize();



///DEFAULT ASPECT RATIO IS 16:9
//Define the camera size
globalvar cameraWidth;
globalvar cameraHeight;
cameraWidth = 640;
cameraHeight = 360;

//Set window size
window_set_size(cameraWidth * 2, cameraHeight * 2);



//Define keys
globalvar keyLeft, keyLeftPressed, keyRight, keyRightPressed, keyDown, keyDownPressed, keyUp, keyUpPressed; 
globalvar keySpacePressed, keyEscapePressed, mouseLeft, mouseLeftPressed, mouseRight, mouseMiddle, mouseMiddlePressed;
globalvar keyCtrl, keyAlt, keyRPressed, keySPressed, keyOPressed, keyE, keyQ, keyT, keyLPressed;


//Define first room
#macro ROOMSTART rMain
#macro LevelEditor:ROOMSTART rLevelEditor

firstRoom = ROOMSTART;
alarm_set(0, 1);


//Define volume variabkes
globalvar volume;
volume = 0.8;

globalvar musicVolume;
musicVolume = 0.85;