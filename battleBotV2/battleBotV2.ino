#include <Wire.h>
#include <Zumo32U4.h>

Zumo32U4Motors motors;
Zumo32U4LineSensors lineSensors;
Zumo32U4ProximitySensors proxSensors;
Zumo32U4Buzzer buzzer;

#define NUM_SENSORS 5
uint16_t lineSensorValues[NUM_SENSORS];

int speed = 150; // Adjust motor speed through GUI
const int turnSpeed = 300;
const int attackSpeed = 400;
const int MAX = 500; // line sensor treshold
const int frontMAX = 300; // front sensor treshold

uint16_t lastSampleTime = 0;
char currentMode = '0';

void setup() {
  Serial1.begin(9600);
  lineSensors.initThreeSensors();
  proxSensors.initThreeSensors();
}

// for buzzer
unsigned long previousMillis = 0;
int frequencyIndex = 0;
int frequencies[] = {200, 300, 400, 500, 600, 700, 800, 900};
const int frequencyCount = sizeof(frequencies) / sizeof(frequencies[0]);
const int buzzerInterval = 100;

void loop() {
  proxSensors.read();

  if (Serial1.available()) {
    char input = Serial1.read();
    if (input == '1' || input == '2') {
      currentMode = input;
    }
  }

  if (currentMode == '1') {
    autoMode();
  } else if (currentMode == '2') {
    manualMode();
  }
}

void autoMode() {
  // Serial1.println("Automatic Mode");
  // Serial1.println(lineSensorValues[1]);


  // Sample the line sensors every 100 milliseconds
  if ((uint16_t)(millis() - lastSampleTime) >= 100)
  {
    lastSampleTime = millis();
    lineSensors.read(lineSensorValues);
  }


  if (lineSensorValues[0] > frontMAX && lineSensorValues[2] > frontMAX) { // wall front --> turn
    // Serial1.println("Front Wall");

    motors.setLeftSpeed(-speed);
    motors.setRightSpeed(-speed);
    delay(300);
    motors.setLeftSpeed(turnSpeed);
    motors.setRightSpeed(-turnSpeed);
    delay(400);
  }

  else if (lineSensorValues[0] > MAX) { // wall left --> adjust to the right
    // Serial1.println("Left Wall");

    motors.setLeftSpeed(turnSpeed);
    motors.setRightSpeed(-turnSpeed);
    delay(300);
  }

  else if (lineSensorValues[2] > MAX) { // wall right --> adjust to the left
    // Serial1.println("Right Wall");

    motors.setLeftSpeed(-turnSpeed);
    motors.setRightSpeed(turnSpeed);
    delay(300);
  }

  else if (lineSensorValues[1] >= 140 && lineSensorValues[1] < 200) { // RED ZONE
    Serial1.println("Spin!");

    motors.setLeftSpeed(-turnSpeed);
    motors.setRightSpeed(turnSpeed);
    delay(1500);
  }
  

  int leftSensor = proxSensors.countsLeftWithLeftLeds();
  int centerLeftSensor = proxSensors.countsFrontWithLeftLeds();
  int centerRightSensor = proxSensors.countsFrontWithRightLeds();
  int rightSensor = proxSensors.countsRightWithRightLeds();

  unsigned long turnStartTime = 0;
  unsigned long turnDuration = 100; // Set the turn duration in milliseconds

  // Set the turn speed
  int turnSpeed = 300;

  // If an object (enemy Zumo) is detected, follow it
  if (centerLeftSensor > 4.5 && centerRightSensor > 4.5) {
    Serial1.println("ATTACK!");
    motors.setSpeeds(400, 400);

    // playBuzzerSequence();

  }
  // If an object (enemy Zumo) is detected on the left, turn left
  else if (centerLeftSensor > 4.5 || leftSensor > 4.5) {
    buzzer.playFrequency(300, 100, 9);
    Serial1.println("Enemy Left!");

    int leftSpeed = -turnSpeed;
    int rightSpeed = turnSpeed;

    motors.setLeftSpeed(leftSpeed);
    motors.setRightSpeed(rightSpeed);
  }
  // If an object (enemy Zumo) is detected on the right, turn right
  else if (centerRightSensor > 4.5 || rightSensor > 4.5) {
    buzzer.playFrequency(300, 100, 9);
    Serial1.println("Enemy Right!");

    int leftSpeed = turnSpeed;
    int rightSpeed = -turnSpeed;

    motors.setLeftSpeed(leftSpeed);
    motors.setRightSpeed(rightSpeed);
  }
  else {
    motors.setSpeeds(speed, speed);
  }
}

void playBuzzerSequence() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= buzzerInterval) {
    previousMillis = currentMillis;

    if (frequencyIndex < frequencyCount) {
      buzzer.playFrequency(frequencies[frequencyIndex], buzzerInterval - 10, 10);
      frequencyIndex++;
    } else {
      frequencyIndex = 0; // Reset the sequence
    }
  }
}

void manualMode() {
  Serial1.println("Manual Mode");

  while (currentMode == '2') {
    if (Serial1.available()) {
      char command = Serial1.read();
      switch (command) {
        case 'z': // Move forward
          // Serial1.println("Moving Forward");
          motors.setLeftSpeed(speed);
          motors.setRightSpeed(speed);
          break;
        case 's': // Move backward
          // Serial1.println("Moving Back");
          motors.setSpeeds(-speed, -speed);
          break;
        case 'q': // Turn left
          // Serial1.println("Turning Right");
          motors.setSpeeds(-speed, speed);
          break;
        case 'd': // Turn right
          // Serial1.println("Turning Left");
          motors.setSpeeds(speed, -speed);
          break;
        case '5': // Stop
          Serial1.println("STOP!");
          motors.setSpeeds(0, 0);
          break;
        case '8':
          Serial1.println("ATTACK!");
          motors.setSpeeds(attackSpeed, attackSpeed);
          break;
        case '4':
          Serial1.println("SPIN LEFT!");
          motors.setSpeeds(-attackSpeed, attackSpeed);
          break;
        case '6':
          Serial1.println("SPIN RIGHT!");
          motors.setSpeeds(attackSpeed, -attackSpeed);
          break;

        case '1': // Switch to mode 1
          currentMode = '1';
          break;
        default:
          break;
      }
    } 
  }
}