# Zumo32U4 Battle Bot

This repository contains the source code for a Zumo32U4 battle bot. The code supports two control modes: automatic and manual. In automatic mode, the robot navigates in an arena and detects other object, such as another robot. In manual mode, the user can control the robot's movements using commands sent through the serial interface.

## Installation

* Install the Arduino IDE on your computer.
* Install the Zumo32U4 library by following the instructions in the library's README file.
* Connect your Zumo32U4 robot to your computer via USB.
* Open the Arduino IDE, and open the provided .ino file.
* Select the appropriate board and port in the Arduino IDE (Tools > Board > Pololu A-Star 32U4 > Zumo32U4).
* Upload the code to the robot by clicking the "Upload" button in the Arduino IDE.

Links:
* ArduinoIDE: https://www.arduino.cc/en/software
* Zumo32U4 library: https://github.com/pololu/zumo-32u4-arduino-library

## Running the program
* Power on the Zumo bot
* Creata a serial connection between the robot and your computer, using 9600.
* Send commands to control the robot.
  * Press '1' for automatic mode
  * Press '2' for manual mode

## Manual Mode Commands

* 'z': Move forward
* 's': Move backward
* 'q': Turn left
* 'd': Turn right
* '5': Stop
* '8': Attack (move forward quickly)
* '4': Spin left
* '6': Spin right

## Code Overview

The code initializes the Zumo32U4 motors, line sensors, proximity sensors, and buzzer. It then enters a loop that continuously checks for serial input to switch between automatic and manual modes. The robot's behavior in each mode is controlled by the autoMode() and manualMode() functions.

In automatic mode, the robot navigates its environment, adjusting its movement based on the readings from its line and proximity sensors. It can also detect and follow an object, such as another robot.

In manual mode, the robot responds to user commands sent through the serial interface.

