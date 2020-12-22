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

//Define has centered window
globalvar hasCenteredWindow;
hasCenteredWindow = false;



//Define keys
globalvar keyLeft, keyLeftPressed, keyRight, keyRightPressed, keyDown, keyDownPressed, keyUp, keyUpPressed; 
globalvar keySpacePressed, keyEscapePressed, mouseLeft, mouseLeftPressed, mouseRight, mouseMiddle, mouseMiddlePressed;
globalvar keyCtrl, keyAlt, keyRPressed, keySPressed, keyOPressed, keyE, keyQ, keyT, keyLPressed;



//Define overworld in
globalvar overworldIn;
overworldIn = rTown;

//Define first room
#macro ROOMSTART overworldIn
#macro LevelEditor:ROOMSTART rLevelEditor

firstRoom = ROOMSTART;
alarm_set(0, 1);



//Define volume variabkes
globalvar volume;
volume = 0.75;

globalvar musicVolume;
musicVolume = 0.85;



//Define variables for outline shader
globalvar upixelH, upixelW, texelSize;
upixelH = shader_get_uniform(shOutline, "pixelH");
upixelW = shader_get_uniform(shOutline, "pixelW");
texelSize = 0.001;