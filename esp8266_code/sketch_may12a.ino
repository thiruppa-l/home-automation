#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

ESP8266WebServer server(80);

const char* ssid = "praveen";      // Replace with your Wi-Fi SSID
const char* password = "123456789"; // Replace with your Wi-Fi password

#define relay1 D1
#define relay2 D2
#define relay3 D3
#define relay4 D4

void setup() {
  Serial.begin(9600);
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);

  // Turn off all relays initially
  digitalWrite(relay1, HIGH);
  digitalWrite(relay2, HIGH);
  digitalWrite(relay3, HIGH);
  digitalWrite(relay4, HIGH);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi...");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  
  Serial.println("\nConnected to WiFi");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Define server routes
  server.on("/", HTTP_GET, handleRoot);
  server.on("/car", HTTP_POST, handleCarControl);
  server.begin();
  
  Serial.println("Server started...");
}

void loop() {
  server.handleClient();
}

void handleRoot() {
  String ipAddress = WiFi.localIP().toString();
  String message = "Connected\nIP Address: " + ipAddress;
  server.send(200, "text/plain", message);
}

void handleCarControl() {
  String command = server.arg("command");
  
  Serial.print("Received command: ");
  Serial.println(command);

  if (command == "light_1:on") {
    digitalWrite(relay1, LOW);  // Turn on relay 1
    Serial.println("Relay 1 turned ON");
  } else if (command == "light_2:on") {
    digitalWrite(relay2, LOW);  // Turn on relay 2
    Serial.println("Relay 2 turned ON");
  } else if (command == "light_3:on") {
    digitalWrite(relay3, LOW);  // Turn on relay 3
    Serial.println("Relay 3 turned ON");
  } else if (command == "light_4:on") {
    digitalWrite(relay4, LOW);  // Turn on relay 4
    Serial.println("Relay 4 turned ON");
  } else if (command == "light_1:off") {
    digitalWrite(relay1, HIGH); // Turn off relay 1
    Serial.println("Relay 1 turned OFF");
  } else if (command == "light_2:off") {
    digitalWrite(relay2, HIGH); // Turn off relay 2
    Serial.println("Relay 2 turned OFF");
  } else if (command == "light_3:off") {
    digitalWrite(relay3, HIGH); // Turn off relay 3
    Serial.println("Relay 3 turned OFF");
  } else if (command == "light_4:off") {
    digitalWrite(relay4, HIGH); // Turn off relay 4
    Serial.println("Relay 4 turned OFF");
  } else {
    Serial.println("Invalid command received!");
  }

  server.send(200, "text/plain", "Command received: " + command);
}
