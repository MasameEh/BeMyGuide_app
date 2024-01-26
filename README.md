# Bemyguide App

# Mobile Application for Visually Impaired Assistance

## Overview

This mobile application is designed to assist visually impaired individuals by providing various features and functionalities. Users can switch between Arabic and English languages for a more personalized experience. The application incorporates Assistive Technologies to enhance accessibility.

## Table of Contents

1. [User Interface](#user-interface)
   - [Login Screen](#login-screen)
   - [Reset Password Screen](#reset-password-screen)
   - [Sign Up Screen](#sign-up-screen)
   - [Choose Mode Screen](#choose-mode-screen)
   - [Assistant Mode](#assistant-mode)
   - [ChatGPT Assistant Screen](#chatgpt-assistant-screen)
   - [Settings Screen](#settings-screen)
   - [Glasses Screen](#glasses-screen)
   - [Text Recognition Screen](#text-recognition-screen)
   - [Google Maps Screen](#google-maps-screen)
   - [Video Call Screen](#video-call-screen)
   - [Volunteer Mode](#volunteer-mode)
   - [Joining Meeting as Volunteer](#joining-meeting-as-volunteer)

2. [Features](#features)
   - [ChatGPT](#chatgpt)
   - [Text Extraction and Text-to-Speech](#text-extraction-and-text-to-speech)
   - [Google Maps](#google-maps)
   - [Video Call](#video-call)
   - [Localizations](#localizations)

3. [Connecting Raspberry Pi with Android](#connecting-raspberry-pi-with-android)
   - [FastAPI Integration](#fastapi-integration)
   - [Advantages over Bluetooth and Cloud-based Solutions](#advantages-over-bluetooth-and-cloud-based-solutions)

## User Interface

### Login Screen
The initial screen where users can log in or sign up for a new account. Validation ensures accurate data entry.

### Reset Password Screen
Allows users to reset their password by sending an email with instructions.

### Sign Up Screen
Enables users to create a new account with valid data.

### Choose Mode Screen
Users can select whether they want to volunteer or need assistance.

### Assistant Mode
- Video call connection with volunteers.
- ChatGPT voice assistant in Arabic or English.
- Sending images for recognition.
- Google Maps to detect user location.

### ChatGPT Assistant Screen
Voice-based interaction with ChatGPT supporting both English and Arabic languages.

### Settings Screen
Allows users to update their information or sign out from the application.

### Glasses Screen
Users can send photos to Glasses for face recognition.

### Text Recognition Screen
Used for extracting text from photos and reading it aloud.

### Google Maps Screen
Informs users about their location using voice over.

### Video Call
Users can create or join meetings, and volunteers can assist through video calls.

### Volunteer Mode
Designed for individuals providing assistance, including video calls and ChatGPT support.

## Features

### ChatGPT
Integrates OpenAI's ChatGPT for natural language conversation. Utilizes voice-based interaction for a user-friendly experience.

### Text Extraction and Text-to-Speech
Implements text extraction from images and converts it into spoken words for enhanced accessibility.

### Google Maps
Informs users about their location using Google Maps and voice over.

### Video Call
Enables users to create or join meetings, enhancing communication for assistance.

### Localizations
Supports English and Arabic languages for a personalized experience.

## Connecting Raspberry Pi with Android

### FastAPI Integration
Utilizes FastAPI for seamless communication between the Android app and Raspberry Pi. Offers high performance, automatic documentation, and security features.

### Advantages over Bluetooth and Cloud-based Solutions
- Faster data transfer within the local network.
- Seamless integration without relying on the internet.
- Full control and customization of interactions.
- Enhanced privacy and data security.
- Cost-effectiveness compared to cloud-based solutions.

## Important Notes
- Ensure proper API key configuration for Google Maps.
- Follow Android and iOS setup instructions for video call features.
- Utilize FastAPI for efficient communication between the Android app and Raspberry Pi.

## Conclusion

This comprehensive mobile application aims to empower visually impaired individuals by providing a range of features and functionalities. The integration with Raspberry Pi through FastAPI enhances real-time face recognition capabilities. Users can enjoy a personalized and accessible experience with the support of Assistive Technologies.

