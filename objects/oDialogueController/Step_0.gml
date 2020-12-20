//Set variables depending on the selected message
msg = ourMessages[messageOn, msgData.msg];
name = ourMessages[messageOn, msgData.name];
portraitSprite = ourMessages[messageOn, msgData.port];
portraitIndex = ourMessages[messageOn, msgData.portIndex];

//On space go to next message and start destroying self if we are on the final one
if (canContinueDialogue and keySpacePressed) if (messageOn == array_length(ourMessages) - 1) diaBoxYDest = diaBoxYDestBelow; else {
	messageOn++;
		
	messageToShow = "";
	charOn = 0;
	
	alarm_set(0, 1);
	isAlarmDone = false;
}


//If the alarm is done (the current selected text has been printed) then add to the message the next part
if (isAlarmDone and messageToShow != msg) {
	var char = string_char_at(msg, charOn + 1);
	
	charOn++;
	messageToShow += char;
	
	//Change speed to be faster if we are on a modifier
	var spd = lineSpeed;
	if (char == "&" or char == "|") spd = 1;
	
	alarm_set(0, spd);
	isAlarmDone = false;
}


//Move the dialogue box to it's destination
diaBoxY = lerp(diaBoxY, diaBoxYDest, 0.08);


//If the dialogue box is leaving the screen then destroy self because this is the end of this dialogue
if (diaBoxY >= cameraHeight and diaBoxYDest == diaBoxYDestBelow) instance_destroy(self);