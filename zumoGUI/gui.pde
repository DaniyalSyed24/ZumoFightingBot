
// Variable declarations 
GButton forwardButton; 
GButton autoMode; 
GButton manualMode; 
GButton rightButton; 
GButton leftButton; 
GButton reverseButton; 
GButton stopButton; 
GButton attackButton; 
GButton spinLeftButton;
GButton spinRightButton;

GCustomSlider speedSlider; 
GTextField inputText; 
GTextArea showText; 
GLabel speedLabel; 


public void autoMode_clicked(GButton source, GEvent event) {
  xbee.write("1");
  // delay(100);  // Wait for the data to arrive
  // String serialData = xbee.readString();
  // showText.appendText("\n" + serialData);
  
  showText.appendText("\n Automatic Mode");
}

public void manunualMode_clicked(GButton source, GEvent event) {
  xbee.write("2");
  // delay(100);  // Wait for the data to arrive
  // String serialData = xbee.readString();
  // showText.appendText("\n" + serialData);
  
  showText.appendText("\n Manual Mode");
}

public void forwardButton_clicked(GButton source, GEvent event) {
  xbee.write("z");
  //showText.appendText("\nMoving Forward");
}

public void rightButton_clicked(GButton source, GEvent event) {
  xbee.write("d");
}

public void leftButton_clicked(GButton source, GEvent event) {
  xbee.write("q");
}

public void reverseButton_clicked(GButton source, GEvent event) {
  xbee.write("s");
}

public void stopButton_clicked(GButton source, GEvent event) {
  xbee.write("5");
  showText.appendText("\n STOP!");
}

public void attackButton_clicked(GButton source, GEvent event) {
  xbee.write("8");
  showText.appendText("\n ATTACK!");
}

public void spinLeftButton_clicked(GButton source, GEvent event) {
  xbee.write("4");
  showText.appendText("\n SPIN LEFT!");
}

public void spinRightButton_clicked(GButton source, GEvent event) {
  xbee.write("6");
  showText.appendText("\n SPIN RIGHT!");
}

public void speedSlider_changed(GCustomSlider source, GEvent event) {
  int newSpeed = (int)source.getValueF();
  xbee.write(newSpeed + "\n");
}


public void inputText_change(GTextField source, GEvent event) {
  String inputs = inputText.getText();
  char instruction = inputs.charAt(inputs.length() - 1);
  xbee.write(instruction);
}

public void showText_change(GTextArea source, GEvent event) {
}


public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Battle Bot");
  
  createAutoModeButton();
  createManualModeButton();
  
  createForwardButton();
  createRightButton();
  createLeftButton();
  createReverseButton();
  
  createStopButton();
  createAttackButton();
  createSpinLeftButton();
  createSpinRightButton();
  
  createSpeedSlider();
  createInputText();
  createShowText();
  createSpeedLabel();
}


private void createAutoModeButton() {
  autoMode = new GButton(this, 350, 40, 110, 50);
  autoMode.setText("Automatic Mode");
  autoMode.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  autoMode.addEventHandler(this, "autoMode_clicked");
}

private void createManualModeButton() {
  manualMode = new GButton(this, 350, 110, 110, 50);
  manualMode.setText("Manual Mode");
  manualMode.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  manualMode.addEventHandler(this, "manunualMode_clicked");
}

private void createForwardButton() {
  forwardButton = new GButton(this, 120, 120, 90, 40);
  forwardButton.setText("Forward");
  forwardButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  forwardButton.addEventHandler(this, "forwardButton_clicked");
}

private void createRightButton() {
  rightButton = new GButton(this, 200, 170, 90, 40);
  rightButton.setText("Right");
  rightButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  rightButton.addEventHandler(this, "rightButton_clicked");
}

private void createLeftButton() {
  leftButton = new GButton(this, 40, 170, 90, 40);
  leftButton.setText("Face text");
  leftButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  leftButton.addEventHandler(this, "leftButton_clicked");
}

private void createReverseButton() {
  reverseButton = new GButton(this, 120, 220, 90, 40);
  reverseButton.setText("Reverse");
  reverseButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  reverseButton.addEventHandler(this, "reverseButton_clicked");
}

private void createStopButton() {
  stopButton = new GButton(this, 360, 250, 90, 40);
  stopButton.setText("STOP!");
  stopButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  stopButton.addEventHandler(this, "stopButton_clicked");
}

private void createAttackButton() {
  attackButton = new GButton(this, 360, 190, 90, 40);
  attackButton.setText("ATTACK!");
  attackButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  attackButton.addEventHandler(this, "attackButton_clicked");
}

private void createSpinLeftButton() {
  spinLeftButton = new GButton(this, 310, 310, 90, 40);
  spinLeftButton.setText("SPIN LEFT");
  spinLeftButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  spinLeftButton.addEventHandler(this, "spinLeftButton_clicked");
}

private void createSpinRightButton() {
  spinRightButton = new GButton(this, 410, 310, 90, 40);
  spinRightButton.setText("SPIN RIGHT");
  spinRightButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  spinRightButton.addEventHandler(this, "spinRightButton_clicked");
}


private void createSpeedSlider() {
  speedSlider = new GCustomSlider(this, 50, 40, 240, 50, "blue18px");
  speedSlider.setShowLimits(true);
  speedSlider.setLimits(150.0, 100.0, 500.0);
  speedSlider.setNumberFormat(G4P.DECIMAL, 2);
  speedSlider.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  speedSlider.setOpaque(false);
  speedSlider.addEventHandler(this, "speedSlider_changed");
}

private void createInputText() {
  inputText = new GTextField(this, 105, 310, 120, 30, G4P.SCROLLBARS_NONE);
  inputText.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  inputText.setOpaque(false);
  inputText.addEventHandler(this, "inputText_change");
}

private void createShowText() {
  showText = new GTextArea(this, 520, 30, 210, 330, G4P.SCROLLBARS_NONE);
  showText.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  showText.setOpaque(true);
  showText.addEventHandler(this, "showText_change");
}

private void createSpeedLabel() {
  speedLabel = new GLabel(this, 130, 20, 80, 20);
  speedLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  speedLabel.setText("Speed");
  speedLabel.setOpaque(false);
}
