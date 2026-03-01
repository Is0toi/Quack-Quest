// Joystick pins
const int SW_pin = 2;   // pressed = LOW (INPUT_PULLUP)
const int X_pin  = A0;
const int Y_pin  = A1;

const int PIN_RED    = 3;
const int PIN_BLUE   = 4;
const int PIN_GREEN  = 5;
const int PIN_YELLOW = 6;

const int LED_UP    = PIN_RED;
const int LED_DOWN  = PIN_GREEN;
const int LED_LEFT  = PIN_BLUE;
const int LED_RIGHT = PIN_YELLOW;

// Joystick tuning
const int CENTER = 512;
const int DEADZONE = 140;

void allOff() {
  digitalWrite(LED_UP, LOW);
  digitalWrite(LED_DOWN, LOW);
  digitalWrite(LED_LEFT, LOW);
  digitalWrite(LED_RIGHT, LOW);
}

void setup() {
  pinMode(SW_pin, INPUT_PULLUP);

  pinMode(LED_UP, OUTPUT);
  pinMode(LED_DOWN, OUTPUT);
  pinMode(LED_LEFT, OUTPUT);
  pinMode(LED_RIGHT, OUTPUT);

  allOff();
  Serial.begin(9600);
}

void loop() {
  int xVal = analogRead(X_pin);
  int yVal = analogRead(Y_pin);
  int swVal = digitalRead(SW_pin);

  int dx = xVal - CENTER;
  int dy = yVal - CENTER;

  allOff();

  if (!(abs(dx) < DEADZONE && abs(dy) < DEADZONE)) {
    if (abs(dx) > abs(dy)) {
      if (dx > 0) digitalWrite(LED_RIGHT, HIGH);
      else        digitalWrite(LED_LEFT, HIGH);
    } else {
      if (dy < 0) digitalWrite(LED_UP, HIGH);
      else        digitalWrite(LED_DOWN, HIGH);
    }
  }

  // Send data for Godot: x,y,sw
  Serial.print(xVal);
  Serial.print(",");
  Serial.print(yVal);
  Serial.print(",");
  Serial.println(swVal);

  delay(20);
}
