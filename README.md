# 🏠 Home Automation Project

This project enables remote control of home appliances using a combination of hardware (ESP32/ESP8266), sensors, and a mobile application. It enhances convenience, energy efficiency, and security in smart homes.

![Home Automation](https://www.researchgate.net/profile/Ravindra-Singh-66/publication/343332604/figure/fig1/AS:923469285441536@1596194153658/Basic-home-automation-system.png)

---

## 📦 Features

- Control lights, fans, and other appliances via mobile app
- Monitor device status in real-time
- Voice control integration (optional)
- Secure wireless communication (via Wi-Fi)

---

## 🧰 Technologies Used

- **ESP8266/ESP32** – Main microcontroller
- **Relays & Sensors** – For controlling and monitoring appliances
- **Flutter App** – To control devices remotely
- **Firebase** – Realtime database (optional)

---

## 📁 Project Structure

home_automation_project/
├── esp_code/ # Arduino (.ino) code for ESP8266/ESP32
├── flutter_app/ # Flutter mobile app to control appliances
└── README.md


---

## 🚀 Setup Instructions

### 📡 Hardware
1. Connect relays to ESP8266/ESP32 GPIO pins.
2. Add sensors (temperature, motion, etc.) if required.
3. Power the ESP board via USB or 5V adapter.

### 📲 Mobile App
1. Open the `flutter_app` folder in VS Code or Android Studio.
2. Run `flutter pub get`.
3. Connect your phone/emulator and run the app.

### 🔌 Flash ESP Code
1. Install Arduino IDE.
2. Open `.ino` file from `esp_code/`.
3. Select the correct board and port, then upload.

---

## 📱 App Screenshots (Optional)
You can add screenshots of your Flutter app here later.

---

## ⚠️ Disclaimer

This is a DIY project intended for educational purposes. Handle high-voltage appliances with proper safety precautions.

---

## 🌟 Author

Developed by **Thiruppa Lakshmanan**  
[GitHub Profile](https://github.com/thiruppa-l)

---
