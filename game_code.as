// // // Code for SCENES
// // scTitle
/*
	 Name: Victor Campos
	 Project: Haunted House Adventure
	 Date: 2024-07-31
	 Description: A point and click game where you
	 Notes: Summer 2024 final project.
*/     

// Activate libraries
import flash.events.TouchEvent;	// For touch/drag
import flash.geom.Rectangle;	// For drag boundaries
import flash.media.Sound;		// For sound 
import flash.media.SoundChannel;// For sound 

// Stop auto-play Timeline
stop();

// Activate touch mode. VERY IMPORTANT!
Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

trace("Game is ready!");

// Go to scHelp subroutine (Event Listener & Function)
btnHelpGet.addEventListener(TouchEvent.TOUCH_TAP, fnGoToScHelp);
function fnGoToScHelp(event:TouchEvent):void {
	trace("fnGoToScHelp() is running");
	// From the current Scene to the other Scene
	MovieClip(this.root).gotoAndPlay(1, "scHelp");
}; // END fnGoToScHelp() code

// Go to scCharacters Event Listener. Note different Function call.
btnGameStart.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scCharacters"); });

// Generic goToScene() subroutine
function fnGoToScene(event:TouchEvent, scScene:String):void {
	trace("Going to:", scScene);
	// Move to Scene based on Scene Name (String) input
	MovieClip(this.root).gotoAndPlay(1, scScene);
}; // END fnGoToScene()

// Load a certain Frame from the Symbol Timeline
btnGameStart.gotoAndStop(1);

// =========== Inventory System Code =========== //
// Set up Inventory System Variables (Boolean)
var invKeySkull:Boolean	= false;
var invKeyFlame:Boolean	= false;
var invSecret:Boolean	= false;
trace("Have the Skull Key?", invKeySkull);
// Secret reward tracker
var invReward:Number = 1;

// =========== Character Select Code =========== //
// Random Stats generator. Returns a Number.
function rndStats():Number {
	trace("rndStats() is running");
	// Array to store a collection of luck
	var arrLuck:Array = [10, 25, 50, 75, 100];
	// Pick a random position of the Array
	var arrLuckPicked:Number = Math.floor(Math.random() * arrLuck.length);
	// Return the luck when called
	return arrLuck[arrLuckPicked];
}; // END rndStats()

// Define the Characters (Objects) and Attribues (Properties)
// Sets static and dynamic Properties
var Mage:Object = {
	"cName":"Vanter",
	"cType":"mage",
	"cHP":50,
	"cMP":100,
	"cPow":25,
	"cLuck": rndStats()
}; // END Mage Object (Character)

var Warrior:Object = {
	"cName":"Mung",
	"cType":"warrior",
	"cHP":75,
	"cMP":25,
	"cPow":100,
	"cLuck": rndStats()
}; // END Warrior Object

var Priest:Object = {
	"cName":"Jazrelle",
	"cType":"priest",
	"cHP":55,
	"cMP":10,
	"cPow":10,
	"cLuck": rndStats()
}; // END Priest Object

var Thief:Object = {
	"cName":"Zaxxor",
	"cType":"thief",
	"cHP":25,
	"cMP":0,
	"cPow":25,
	"cLuck": rndStats()
}; // END Mage Object

trace("Mage name:", Mage.cName);
trace("Mage hit points:", Mage.cHP);
trace("Mage power:", Mage.cPow);
trace("Mage luckiness:", Mage.cLuck);
trace("Warrior luck:", Warrior.cLuck);
trace("Priest luck:", Priest.cLuck);
trace("Thief luck:", Thief.cLuck);

// Code to keep track of all Characters, and which selected
var charAll:Array = [null, "Mage", "Warrior", "Priest", "Thief"];
var charAllObj:Array = [null, Mage, Warrior, Priest, Thief];
var charSelected:String = null;
var charSelectedNumber:Number = 0;

// =========== Background Music Code =========== //
// FIRST (at the top) set up the ability to use sound
// Create a variable to "hold" the sound, from the Library
// Note: is based on the Linkage of the Library item
var musicTitle:musTitle = new musTitle();
// Create a variable for "playing" the sound, and loop the sound once
var musicTitlePlay:SoundChannel = musicTitle.play(0, 1);
// Create a variable to keep track of the music playing, for pausing
var musicTitlePause:Number = 0;

// If any other sounds are playing, end those
SoundMixer.stopAll();

// Based on the pause number, re-start playing the music there
musicTitlePlay = musicTitle.play(musicTitlePause, 1);

// Detect (listen) for pausing the game, to keep track of the frame
NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, fnMusicTitlePause);

// Detect returning to (un-pausing) the game, to restart the music from a frame
NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, fnMusicTitlePlay);
	
// Define the function for pausing the music. NOTE it's :Number *not* :void
function fnMusicTitlePause(event:Event):Number {
	trace("fnMusicTitlePause() is running");
	// Set the current frame of the music
	musicTitlePause = musicTitlePlay.position;
	// Stop the music so it doesn't play in another app
	SoundMixer.stopAll();
	// Return the frame of music
	return musicTitlePause;
} // END fnMusicTitlePause()

// Define the function for re-starting the music
function fnMusicTitlePlay(event:Event):void {
	trace("fnMusicTitlePlay() is running");
	musicTitlePlay = musicTitle.play(musicTitlePause, 1);
} // END fnMusicTitlePlay()


// // scHelp
stop();
trace("You are now in the Help Screen");

// Using generic fnGoToScene() to return the scTitle
btnGoBack.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scTitle"); });

// Display the 3rd frame of the generic button: Back
btnGoBack.gotoAndStop(3);

// Display the 2nd frame of the genric button: Exit game
btnHelpExit.gotoAndStop(2);

// Subroutine to exit the app, using Navite Code
btnHelpExit.addEventListener(TouchEvent.TOUCH_TAP, fnHelpExitGame);
function fnHelpExitGame(event:TouchEvent):void {
	trace("About to exit the game (no confirmation)");
	// NOTE: That's a 'Zero' not an "Oh"!
	NativeApplication.nativeApplication.exit(0); 
}; // END fnEndGoodExitGame()


// // scCharacters
stop();
trace("At scCharacters");

// Set the right graphic for each instance, using Frame labels
spMage.gotoAndStop("Mage");
spWarrior.gotoAndStop("Warrior");
spPriest.gotoAndStop("Priest");
spThief.gotoAndStop("Thief");

// Display the 6th frame of the generic button: go to next cut scene
btnGoGate.gotoAndStop(6);

// But, HIDE button until character selection
btnGoGate.visible = false;

// Each character is clickable and then updates the "selected" code
spMage.addEventListener(TouchEvent.TOUCH_TAP, 	
	function(event){ fnCharSelect(event, 1) });
spWarrior.addEventListener(TouchEvent.TOUCH_TAP, 	
	function(event){ fnCharSelect(event, 2) });
spPriest.addEventListener(TouchEvent.TOUCH_TAP, 	
	function(event){ fnCharSelect(event, 3) });
spThief.addEventListener(TouchEvent.TOUCH_TAP, 	
	function(event){ fnCharSelect(event, 4) });

// Subroutine for selecting plyable Character
// NOTE: the second Paramater in the Function definition
function fnCharSelect(event:TouchEvent, charNumber:Number):void {
	trace("fnCharSelect() is running");
	trace("charNumber:", charNumber);
	// Set variables to the one that was picked
	charSelected = charAll[charNumber];
	trace("charSelected:", charSelected);
	charSelectedNumber = charNumber;
	trace("charSelectedNumber:", charSelectedNumber);
	
	// Hilight the one that's picked, fade out the others
	// Using a switch() Condtional Statement
	switch(charNumber){
		case 1:
			spMage.alpha	= 1;
			spWarrior.alpha	= 0.25;
			spPriest.alpha	= 0.25;
			spThief.alpha	= 0.25;
			break;
		case 2:
			spMage.alpha	= 0.25;
			spWarrior.alpha	= 1;
			spPriest.alpha	= 0.25;
			spThief.alpha	= 0.25;
			break;
		case 3:
			spMage.alpha	= 0.25;
			spWarrior.alpha	= 0.25;
			spPriest.alpha	= 1;
			spThief.alpha	= 0.25;
			break;
		case 4:
			spMage.alpha	= 0.25;
			spWarrior.alpha	= 0.25;
			spPriest.alpha	= 0.25;
			spThief.alpha	= 1;
			break;
	}; // END switch() picker
	
	// Now, show the next Scene button
	btnGoGate.visible = true;
}; // END fnCharSelect()

// Activate the now-visible button
btnGoGate.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scGateCutscene"); });


// // scGateCutscene
stop();
trace("At scGateCutscne");

// Show "Next" button text
btnGoNextGate.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextGate.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scGate"); });


// // scGate
stop();
trace("Now at scGate");

btnWall01Gate.addEventListener(TouchEvent.TOUCH_TAP, fnPlayGateAnim);
function fnPlayGateAnim(event:TouchEvent):void {
	trace("fnPlayGateAnim() is running");
	// Before we move to the next scene play the animation of the door
	btnWall01Gate.play();
	// INSIDE the btnWall01Gate Object, move us to the next scene
}; // END fnPlayGateAnim()

// =========== Background Music Code START =========== //
SoundMixer.stopAll();    
var musicMain:musMain = new musMain();
var musicMainPlay:SoundChannel = musicMain.play(0, 99);
var musicMainPause:Number = 0;

NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
	fnMusicMainPause);
NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
	fnMusicMainPlay);

function fnMusicMainPause(event:Event):Number {
	trace("fnMusicMainPause() is running");
	musicMainPause = musicMainPlay.position
	trace("Paused at: ", musicMainPause);
	SoundMixer.stopAll();
	return musicMainPause;
} // END fnMusicMainPause()

function fnMusicMainPlay(event:Event):void {
	trace("fnMusicMainPlay() is running");
	musicMainPlay = musicMain.play(musicMainPause+1, 99);
} // END fnMusicMainPlay()

// Also deactivate any previous listeners!!!
NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, 
	MovieClip(this.root).fnMusicTitlePause);

NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, 
	MovieClip(this.root).fnMusicTitlePlay);
//... probably needed elswhere...
// =========== Background Music Code END =========== //

// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);
function fnOpenInventory(event:TouchEvent):void {
	trace("fnOpenInventory() is running");

	// Clicked button, so, animate inventory opening
	btnInventory.play();
	
	// Then show/hide keys as necessary
	if(invKeySkull == true) {
			// Got key, so show its graphic
			btnInventory.invKey01.visible = true;
		} else {
			// Don't have key, so DON'T show its graphic			
			btnInventory.invKey01.visible = false;
		}; // END If..Else show item
	
	if(invKeyFlame == true) {
			// Got key, so show its graphic
			btnInventory.invKey03.visible = true;
		} else {
			// Don't have key, so DON'T show its graphic			
			btnInventory.invKey03.visible = false;
		}; // END If..Else show item
	
	if(invSecret == true) {
			btnInventory.invKey02.gotoAndStop(invReward);
			// Got reward, so show its graphic
			btnInventory.invKey02.visible = true;
		} else {
			// Don't have key, so DON'T show its graphic			
			btnInventory.invKey02.visible = false;
		}; // END If..Else show item
}; // END fnOpenInventory


// // scFrontDoorCutscene
stop();
trace("At scFrontDoorCutscene");

// Show "Next" button text
btnGoNextGate.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextGate.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scFrontDoor"); });


// // scFrontDoor
stop();
trace("Now at Front Door");

frontDoor.addEventListener(TouchEvent.TOUCH_TAP, fnFrontDoorAnim);
function fnFrontDoorAnim(event:TouchEvent):void {
	trace("fnFrontDoorAnim() is running");
	// Play the timeline of the symbol (its animation); "dead end"
	frontDoor.play();
}; // END fnFrontDoorAnim()

frontTree.addEventListener(TouchEvent.TOUCH_TAP, fnFrontTreeAnim);
function fnFrontTreeAnim(event:TouchEvent):void {
	trace("fnFrontTreeAnim() is running");
	frontTree.play();
	// NOTE: .removeEventListner is INSIDE that symbol; "dead end"
}; // END fnFrontTreeAnim()

// Rectangle boundary for dragging the rock object
var rockBoundaries:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

// Two .addEventListeners for when we BEGIN to drag, and END to drag
frontRock.addEventListener(TouchEvent.TOUCH_BEGIN, fnRockStartMove);
frontRock.addEventListener(TouchEvent.TOUCH_END, fnRockStopMove);

// Two functions for detecting start/stop drag
function fnRockStartMove(event:TouchEvent):void {
	trace("fnRockStartMove() is running");
	// Allow the rock to move around the boundaries (all screen)
	event.target.startTouchDrag(event.touchPointID, false, rockBoundaries);
}; // END fnRockStartMove()
function fnRockStopMove(event:TouchEvent):void {
	trace("fnRockStopMove() is running");
	// Detect that we've stopped
	event.target.stopTouchDrag(event.touchPointID);
	// Conditional Statement to detect collision
	// THISOBJECT.hitTestObject(THATOBJECT);
	if(frontRock.hitTestObject(frontWindow)) {
		// True section
		trace("The Rock touched the Window")
		// Play the timeline of the window breaking
		// and then move us to scHallMain
		frontWindow.play();
	} else {
		// False, do nothing
		trace("The rock didn't touch the window")
	} // END If..Else detection checker
}; // END fnRockStopMove()

// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);


// // scHallMainCutscene
stop();
trace("At scHallMainCutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scHallMain"); });



// // scHallMain
stop();
trace("You're at Main Hall")

hallwayPainting.addEventListener(TouchEvent.TOUCH_TAP, fnPaintingAnim);
function fnPaintingAnim(event:TouchEvent):void {
	trace("fnPaintingAnim() is running");
	hallwayPainting.play();
	// Animation and code IN the symbol of hallwayPainting, for loops
}; // END fnPaintingAnim()

// Hidden key subroutine
keySkull.addEventListener(TouchEvent.TOUCH_TAP, fnKeyGet);
function fnKeyGet(event:TouchEvent):void {
	trace("fnKeyGet() is running");
	// "Picked up" the key, so set to "true"
	invKeySkull = true;
	trace("Got the Skull Key?", invKeySkull);
	// Remove skull from screen, and "put" it into Inventory
	MovieClip(this.root).removeChild(keySkull);
	keySkull.removeEventListener(TouchEvent.TOUCH_TAP, fnKeyGet);
}; // END fnKeyGet()

rightHallway.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scRightHall01Cutscene"); });
leftHallway.addEventListener(TouchEvent.TOUCH_TAP,  function (event) { fnGoToScene(event, "scLeftHall01Cutscene"); });

// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);


// // scHallRightCutscene
stop();
trace("At scRightHall01Cutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scRightHall01"); });


// // scHallRight01 // FRAME 01
// stop(); // REMOVE!!!
trace("You are on the rightward path hallway");

// Keep track of if Mini Boss defeated or not
var hallRightMiniBossDead01:Boolean = false;
trace("Is mini boss defeated?", hallRightMiniBossDead01);

// Set up interaction with the door based on Mini Boss
rightDoor.addEventListener(TouchEvent.TOUCH_TAP, fnGoEnding);
function fnGoEnding(event:TouchEvent):void {
	trace("fnGoEnding() is running");
	
	// First check if boss defeated, then move us to next else
	// or else, not defeated, so keep us here
	if(hallRightMiniBossDead01 == true) {
		trace("TRUE, boss is defeated");
		MovieClip(this.root).gotoAndPlay(1, "scEndGoodCutscene");
	} else { 
		trace("FALSE, is not defeated");
		// To-do: play a sad sound
	} // END If..Else checking if mini boss defeated
}; // END fnGoEnding()

// Track boss hitpoints
var hallRightMiniBossHP:Number = 0;

// Set up tapping (battling) the boss
// .addEventListener() in Frame 10!
function fnMiniBossBattle01(event:TouchEvent):void {
	trace("fnMiniBossBattle01() is running");
	// Add one hit to the boss' HP
	hallRightMiniBossHP++; // Increments to a limit
	//hallRightMiniBossHP--; // Or, Decrements to a minimum
	trace("Boss hits:", hallRightMiniBossHP);
	// Then check if boss has been battled enough
	if(hallRightMiniBossHP > 10) {
		trace("Boss is defeated!");
		// Change to TRUE
		hallRightMiniBossDead01 = true;
		
		// To-do: First play a death animtion, then remove sprite
		// MovieClip(this.root).miniBoss01.play(51);
		
		// Remove the mini boss sprite
		MovieClip(this.root).removeChild(miniBoss01);
		
		// Stop the ""timer"" (the timeline)
		MovieClip(this.root).stop();
		
		// Play the secret door animation
		hallwayRightSecretDoor.play();
	} else {
		trace("Keep fighting!");
	}; // END If..Else checking boss hits
}; // END fnMiniBossBattle01()

// Secret door subroutine, based on picking up key in scHallMain or not
hallwayRightSecretDoor.addEventListener(TouchEvent.TOUCH_TAP, fnSecret01);
function fnSecret01(event:TouchEvent):void {
	trace("fnSecret01() is running");
	
	// Before opening the door, check if we have the skull key
	if(invKeySkull == true && hallRightMiniBossDead01 == true) {
		trace("TRUE: we have the skull key");
		hallwayRightSecretDoor.gotoAndPlay(22);
	} else {
		trace("FALSE: WE DO NOT HAVE THE SKULL KEY YET");
		hallwayRightSecretDoor.play();
	}; // END If..Else skull checker
}; // END fnSecret01()


// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);


// // scHallRight01 // FRAME 10
// Because boss graphic exists HERE
// the .addEventListener() is HERE
miniBoss01.addEventListener(TouchEvent.TOUCH_TAP, fnMiniBossBattle01);


// // scHallRight01 // FRAME 100
// Time ran out! Move to bad ending
MovieClip(this.root).gotoAndPlay(1, "scEndBadCutscene");


// // scSecret01Cutscene
stop();
trace("At scSecret01Cutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scSecret01"); });

// Selected character subroutine, to change on-screen text
trace("You are:",  charAllObj[charSelectedNumber].cName);
trace("You have:", charAllObj[charSelectedNumber].cLuck);
// Make sure to set text field as Dynamic text type; and Instance Name
txtLuck.text = charAllObj[charSelectedNumber].cLuck;


// // scSecret01
stop();
trace("scSecret01");

// Set no reward picked up
invReward = 4;

// Conditional statement based on luck range: Bad, Neutral, Good
if (charAllObj[charSelectedNumber].cLuck < 50) {
	trace("Bad luck");
	spReward01.gotoAndStop(3);
} else if (charAllObj[charSelectedNumber].cLuck > 50) {
	trace("Good luck");
	spReward01.gotoAndStop(1);
} else {
	trace("Neutral luck");
	spReward01.gotoAndStop(2);
} // END If..Else If checking luck

btnDoorSec01.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scLeftHall01bCutscene"); });

spReward01.addEventListener(TouchEvent.TOUCH_TAP, fnGetReward);
function fnGetReward(event:TouchEvent):void {
	trace("fnGetReward() is running");
	invSecret = true;
	
	MovieClip(this.root).removeChild(spReward01);
	spReward01.removeEventListener(TouchEvent.TOUCH_TAP, fnGetReward);
	
	if (charAllObj[charSelectedNumber].cLuck < 50) {
		invReward = 3;
	} else if (charAllObj[charSelectedNumber].cLuck > 50) {
		invReward = 1;
	} else {
		invReward = 2;
	} // END If..Else to set which item 
	
	trace("Got the reward?", invSecret, "Which?", invReward);
}; // END fnKeyGet()

// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);


// // scLeftHall01bCutscene (after secret path)
stop();
trace("At scLeftHall01bCutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the collected treasure, based on Frame Number
spReward02.gotoAndStop(invReward);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scLeftHall01Cutscene"); });

// Conditional statement based on which reward got, change text
if (invReward == 1) {
	trace("Bird"); 
	txtReward01.text = "Thank the gods! We found the Golden Bird of An-tar! This relic is worth a fortune! We had great luck today! \n \n Now, let us proceed.";
} else if (invReward == 3) {
	trace("Skull");
	txtReward01.text = "Oh, no! The gods have cursed us with bad luck today. We have found Azalay's Skull. \n \n Let us proceed cautiously.";
} else if (invReward == 2) {
	trace("Cup");
	txtReward01.text = "Our seems to be neutral. As such, this esoteric chalice is our just reward. \n \n Onward!";	
} else {
	trace("None");
	spReward02.visible = false;
	txtReward01.text = "Whatever our luck was, it was not right to tempt fate! Let us leave any supposed treasure and proceed...";
} // END If..Else If checking luck

// // scLeftHall01Cutscene
stop();
trace("At scLeftHall01Cutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scLeftHall01"); });


// // scLeftHall01 // FRAME 01
// stop(); // REMOVE THIS!!
trace("You are on the leftward path hallway");

// Create a variable to store all keys (From the Library)
// :leftKeys - the data type (instead of Number, Boolean)
// ------ BASED ON LINKAGE!
// new leftKeys() - syntax meaning the Object in the Library
var key01:leftKeys = new leftKeys();

// Subroutine for putting a Specific Library item on-screen
// Then display that instance on-screen
MovieClip(this.root).addChild(key01);
// Set the key01 coordinates (from the top-left)
key01.x = 100;
key01.y = 400;
// Then show only frame 1 of the keys
key01.gotoAndStop(1);

// Examples of putting a RANDOM Library item RANDOMLY on-screen
// First generate some random numbers: X:0 - 400  Y:400 - 480
var rnd2X:Number = Math.round(Math.random() * 400); 
var rnd2Y:Number = Math.round(Math.random() * 80) + 400;
var key02:leftKeys = new leftKeys();
MovieClip(this.root).addChild(key02);
key02.x = rnd2X;
key02.y = rnd2Y;
key02.gotoAndStop(2);

// Add a third key AND make it clickable
var rnd3X:Number = Math.round(Math.random() * 400); 
var rnd3Y:Number = Math.round(Math.random() * 80) + 400;
var key03:leftKeys = new leftKeys();
MovieClip(this.root).addChild(key03).addEventListener(TouchEvent.TOUCH_TAP, fnGetLeftKey);
key03.x = rnd3X;
key03.y = rnd3Y;
key03.gotoAndStop(3);

// Define function for picking the right random key
function fnGetLeftKey(event:TouchEvent):void {
	trace("fnGetLeftKey() is running");
	
	// Remove each key before proceeding
	MovieClip(this.root).removeChild(key01);
	MovieClip(this.root).removeChild(key02);
	MovieClip(this.root).removeChild(key03);
	
	// Jump to spike retraction animation
	gotoAndPlay(89);
} // END fnGetLeftKey


// ------- INVENTORY CODE ------- //
btnInventory.addEventListener(TouchEvent.TOUCH_TAP, fnOpenInventory);


// // scLeftHall01 // FRAME 72
// Didn't grab correct key, go to BAD ending

// First remove the keys from on-screen
MovieClip(this.root).removeChild(key01);
MovieClip(this.root).removeChild(key02);
MovieClip(this.root).removeChild(key03);
MovieClip(this.root).gotoAndPlay(1, "scEndBadCutscene");


// // scLeftHall01 // FRAME 120
// Grabbed the correct key, after reverse spikes anim, go to GOOD ending cut scene
MovieClip(this.root).gotoAndPlay(1, "scEndGoodCutscene");


// // scEndGoodCutscene
stop();
trace("At scEndGoodCutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scEndGood"); });


// // scEndGood
stop();
trace("Entered scGood");
// Show the right frame of the generic button
btnEndGoodExit.gotoAndStop(2);

// Set up button to exit the game
// without confirmation, just EXIT
btnEndGoodExit.addEventListener(TouchEvent.TOUCH_TAP, fnEndGoodExitGame);
function fnEndGoodExitGame(event:TouchEvent):void {
	trace("About to exit the game (no confirmation)");
	// NOTE: That's a 'Zero' not an "Oh"!
	NativeApplication.nativeApplication.exit(0); 
}; // END fnEndGoodExitGame()

btnEndGoodRestart.gotoAndStop(5);
btnEndGoodRestart.addEventListener(TouchEvent.TOUCH_TAP, fnEndGOODRestartGame);
function fnEndGOODRestartGame(event:TouchEvent):void {
	trace("fnEndGOODRestartGame() is running");
	// To-do when sound is setup
	SoundMixer.stopAll(); // This command stops any sound
	MovieClip(this.root).gotoAndPlay(1, "scTitle");
}; // END fnEndGOODRestartGame()


// // scEndBadCutscene
stop();
trace("At scEndBadCutscene");

// Show "Next" button text
btnGoNextMain.gotoAndStop(4);

// Show the slected character in charHUD, based on Frame Label
charHUD.gotoAndStop(charSelected);

// After reading, proceed
btnGoNextMain.addEventListener(TouchEvent.TOUCH_TAP, function (event) { fnGoToScene(event, "scEndBad"); });

// // scEndBad // FRAME 01
stop();
trace("Bad ending!!")
// Show Exit button frame
btnEndBadExit.gotoAndStop(2);

// Set up button to exit the game
// but first confirm if they really want to exit
btnEndBadExit.addEventListener(TouchEvent.TOUCH_TAP, fnEndBADExitGame);
function fnEndBADExitGame(event:TouchEvent):void {
	trace("About to exit game, ask confirmation first");
	gotoAndStop(5);
}; // END fnEndGoodExitGame()

btnEndBadRestart.gotoAndStop(5);
btnEndBadRestart.addEventListener(TouchEvent.TOUCH_TAP, fnEndBADRestartGame);
function fnEndBADRestartGame(event:TouchEvent):void {
	trace("fnEndBADRestartGame() is running");
	// To-do when sound is setup
	SoundMixer.stopAll(); // This command stops any sound
	MovieClip(this.root).gotoAndPlay(1, "scTitle");
}; // END fnEndBADRestartGame()


// =========== Background Music Code START =========== //
SoundMixer.stopAll();    
var musicEndBAD:musEndBAD = new musEndBAD();
var musicEndBADPlay:SoundChannel = musicEndBAD.play(0, 99);
var musicEndBADPause:Number = 0;

NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
	fnMusicEndBADPause);
NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
	fnMusicEndBADPlay);

function fnMusicEndBADPause(event:Event):Number {
	trace("fnMusicEndBADPause() is running");
	musicEndBADPause = musicEndBADPlay.position
	trace("Paused at: ", musicEndBADPause);
	SoundMixer.stopAll();
	return musicEndBADPause;
} // END fnMusicEndBADPause()
function fnMusicEndBADPlay(event:Event):void {
	trace("fnMusicEndBADPlay() is running");
	musicEndBADPlay = musicEndBAD.play(musicEndBADPause+1, 99);
} // END fnMusicEndBADPlay()

// Also deactivate any previous listeners!!!
NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, 
	MovieClip(this.root).fnMusicMainPause);

NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, 
	MovieClip(this.root).fnMusicMainPlay);
// =========== Background Music Code END =========== //

// // scEndBad // FRAME 05
btnYES.addEventListener(TouchEvent.TOUCH_TAP, fnExitYES);
function fnExitYES(event:TouchEvent):void {
	trace("YES, exit");
	NativeApplication.nativeApplication.exit(0);
}; // END fnExitYES()

btnNO.addEventListener(TouchEvent.TOUCH_TAP, btnExitNO);
function btnExitNO(event:TouchEvent):void {
	trace("NO, close popup");
	gotoAndStop(1);
}; // END btnExitNO()



// // // Code for SYMBOLS
// // btnGenericButton
stop(); // Each button on a Frame


// // spCharacters
stop(); // Each character on a Frame with a Label


// // invMainBox // FRAME 01
stop();
// Hide keys until you get the keys
// NOTE: Do not add btnInventory. because we're IN the box already
invKey01.visible = false;
invKey02.visible = false;
invKey03.visible = false;


// // invMainBox // FRAME 09
stop();


// // spReward
stop(); // Each treasure on a Frame


// // gate01 // FRAME 01 (should rename to spGate01)
stop();

// // gate01 // FRAME 40
// When the animation plays, after a pause, move to the scFrontDoor scene
// MovieClip(this.root).gotoAndPlay(1, "scFrontDoor");

// or to Cut Scene first
MovieClip(this.root).gotoAndPlay(1, "scFrontDoorCutscene");


// // spFrontDoor
stop();


// // spFrontWindow FRAME 01
stop();


// // spFrontWindow FRAME 50
MovieClip(this.root).gotoAndPlay(1, "scHallMainCutscene");


// // spFrontTree FRAME 01
stop();


// // spFrontTree FRAME 11
stop();

// MovieClip(this.root) the main timeline
// Turns OFF the Listener so it no longer runs the Function
// The tree is no longer interactive
// NOTE: .removeEventListener and NOT .addEventListener
// This is a Logic Error, not a Syntax error: you'll get NO feedback
MovieClip(this.root).frontTree.removeEventListener(TouchEvent.TOUCH_TAP, MovieClip(this.root).fnFrontTreeAnim);
	
	
// // spHallwayPainting FRAME 01
stop();
// Keep track of how many animations of the painting
var paintingMoveTimes:Number = 0;


// // spHallwayPainting FRAME 02
// Check the counter at the start
trace("The count is: ", paintingMoveTimes);
// Add one to the counter
paintingMoveTimes++;
// Now check the counter again
trace("The count now is: ", paintingMoveTimes);

// Conditional statement to check number of sways
if(paintingMoveTimes >= 4) { 
	trace("True: we reached the limit");
	// Break out of the loop to play the rest of the animation/code
	gotoAndPlay(13);
} else { 
	trace("False: we HAVEN'T reached the limit");
}; // END If..Else checker for "paintingMoveTimes" counter

// // spHallwayPainting FRAME 12
// So that we don't reset the counter, we'll instead jump to Frame 2
gotoAndStop(2);

// // spHallwayPainting FRAME 20
stop();

MovieClip(this.root).hallwayPainting.removeEventListener(TouchEvent.TOUCH_TAP, MovieClip(this.root).fnPaintingAnim);


// // spHallwayRightSecretDoor FRAME 01
stop();

// // spHallwayRightSecretDoor FRAME 10
stop();

// // spHallwayRightSecretDoor FRAME 19
gotoAndStop(10);

// // spHallwayRightSecretDoor FRAME 50
MovieClip(this.root).gotoAndPlay(1, "scSecret01Cutscene");



// 975 lines of code. Or so. :)