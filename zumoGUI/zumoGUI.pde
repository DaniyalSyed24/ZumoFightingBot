import processing.serial.*;
import g4p_controls.*;

Serial xbee; // declare the serial port for the XBee module

public void setup() {
  String xbeePort = "COM4";
  xbee = new Serial(this, xbeePort, 9600);
  size(750,400);
  createGUI();
}

public void draw() {
  //background(180, 240, 240);
  background(135, 206, 235);
}
