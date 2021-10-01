// All "Serial.print()" statements are for debugging using the serial monitor if rover is not being responsive
//========================Library======================//
#include <SoftwareSerial.h>
#include <HCSR04.h>
#include <Servo.h>
#include <DHT.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include<UltraDistSensor.h>
//=====================================================//
#define DHTPIN 2
//Defines which type of sensor I will be using
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

//========================Int Setup=====================//
Servo motor; // creates a servo object to control Drive Motor
Servo wheel; // creates a servo object to control Steering Motor
Servo Pan; // creates a servo object to control camera Pan 
Servo Tilt; // creates a servo object to control camera Tilt
UltraDistSensor DST; //initialisation class HCSR04 (trig pin , echo pin)
// 
int throttle, steering, sliderVal, button, sliderID;
float distance;
int wheel_left, wheel_right, wheel_center;// Steering Servo variables
int forwards_fast, forwards_medium, forwards_slow, backwards_fast, backwards_medium, backwards_slow, throttle_off; // Motor Servo Varables
int new_value;
int current_value_tilt = 90;
int current_value_pan = 90;
int current_value = 0;
//=====================================================//

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

// Setup code runs once after program starts.

void setup() {
// Servo/Motor Setup
    motor.attach(30); // attaches the servo on pin 30 to the servo motor object
    wheel.attach(40); // attaches the servo on pin 24 to the servo wheel object
    Pan.attach(24); // attaches the servo on pin 24 to the servo pan object
    Tilt.attach(26); // attaches the servo on pin 26 to the servo tilt object
    motor.write(90); // Activating Motor
    motor.write(91); // Activating Motor
    
    // Hummidity and Temperature Senseor Setup
    dht.begin();

    // Ultra Sonic Sound Sensor
    DST.attach(38,39); // Trigger pin, Echo pin

    // LED Lights SetUp
    pinMode(8,OUTPUT);
    pinMode(9,OUTPUT);
    
    // Start serial monitor at 9600 bps.
    Serial.begin(9600);

    //==============Motor Activation Sequence==============//
    motor.write(90);delay(50);
    motor.write(91);delay(50);
    motor.write(90);delay(50);
    motor.write(91);delay(50);
    motor.write(90);delay(50);
    motor.write(91);delay(50);
    motor.write(90);delay(50);
    motor.write(91);delay(50);
    //=====================================================//

    // default//
    wheel_left = 140;
    wheel_right = 50;
    wheel_center = 88;
    forwards_fast = 300;
    forwards_medium = 105;
    forwards_slow = 98;
    backwards_fast = 30;
    backwards_medium = 50;
    backwards_slow = 70;
    throttle_off = 90;

    lcd.init();// initialize the lcd 
    lcd.init();// initialize the lcd
    lcd.backlight();
    lcd.setCursor(1,0);
    lcd.print("setup complete");

    new_value = 0;    
    // Set servo defaults
    Tilt.write(90);
    Pan.write(90);
    wheel.write(wheel_center);
}

void loop() {

if (Serial.available() > 0) //Listen for signal in the serial port
{
int data = Serial.read(); 
switch (data) { // Switch-case of the signals in the serial port
case 'i': // Case i is received, 
motor.write(forwards_medium);
wheel.write(wheel_center);
break;

case 'k' : //// Case k is received, 
motor.write(backwards_medium);
wheel.write(wheel_center);
break;

case 'l' : // Case l is received, 
motor.write(forwards_medium);
wheel.write(wheel_right);
break;

case 'j' : // Case Number 4 is received, 
motor.write(forwards_medium);
wheel.write(wheel_left);
break;

case 'w': // Case w is received, move camera up
new_value = current_value_tilt + 5;
Tilt.write(new_value);
current_value_tilt = new_value;
break;

case 's' : //// Case s is received, move camera down
new_value = current_value_tilt - 5;
Tilt.write(new_value);
current_value_tilt = new_value;
break;

case 'd' : // Case d is received, move camera right
new_value = current_value_pan + 5;
Pan.write(new_value);
current_value_pan = new_value;
break;

case 'a' : // Case a is received, 
new_value = current_value_pan - 5;
Pan.write(new_value);
current_value_pan = new_value;
break;

case 'z' : // Case z is received, Lights On
digitalWrite(8, HIGH);
digitalWrite(9, HIGH);
break;

case 'x' : // Case x is received, Lights Off
digitalWrite(8, LOW);
digitalWrite(9, LOW);
break;

case 'c' : // Case c is received, Print Distance
DisplayDistance();
break;

case 'v' : // Case v is received, Print DHT
DisplayTempHum();  
break;

case 'b' : // Case b is received, Clear Display
ClearScreen();
break;

case 'n' : // Case b is received, Clear Display
TestScreen();
break;

case ' ' : // Case spacebar is received, Stop motor and center
motor.write(throttle_off);
wheel.write(wheel_center);
default : break;

}
}
}
void DisplayDistance()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Processing..");
  delay(750);
  lcd.clear();
  lcd.setCursor(0,0);
  distance=DST.distanceInCm();
  lcd.print("Distance: ~");
  lcd.print(distance);
  return;
}

void DisplayTempHum()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Processing..");
  
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temperature:");
  lcd.print(t);
  lcd.setCursor(0,1);
  lcd.print("Humidity: ");
  lcd.print(h);
  lcd.print("%");
  
  return;
}

void ClearScreen()
{
  lcd.clear();
  return ;  
}

void TestScreen()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Testing 12345678");
  lcd.setCursor(0,1);
  lcd.print("Testing 87654321");
  delay(1500);
  lcd.clear();
  return;
}
