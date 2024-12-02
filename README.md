# enpal_monitor

A Flutter application for data monitoring of solar energy

Developed by: Ali Akber

## Table of Contents

0. [Overview](#0-overview)
1. [Setup Instructions](#1-setup-instructions)
2. [Design_System](#2-design-system)
3. [Architecture Overview](#3-architecture-overview)
4. [Trade Off](#4-trade-off)
5. [Final Notes](#5-final-notes)

## 0. Overview

The mobile application for showing and monitoring power generation and consumption.

Features include:
- Solar data generation graph
- Home energy usage graph
- Battery consumption graph
- Data Pre-Loading
- Date Filtering
- Conversion from Watt to Kilo-Watt
- Caching of data
- Clearing Cached data
- User-friendly error messages
- Pull to refresh on each tab
- Dark mode support
- Unit tests and Widget tests
- Proper documentation

### Video Showcase

Light Theme Android

https://github.com/user-attachments/assets/de7aa67d-df2c-46eb-9211-2a26079c3851

Dark Theme Android

https://github.com/user-attachments/assets/073e7361-4be3-4096-b476-23d05e2f1530

## 1. Setup Instructions

This project was developed using the following Flutter version:

`Flutter 3.24.4 • channel stable • Dart 3.5.4`

### Steps
- Clone the repo into your local machine
- Open the project in you favourite IDE
- Set up the Pre-Commit hooks
- Run `flutter pub get` to get all the dependencies
- Run `flutter run` to run the application

# Installation of Pre-Commit Hook
```bash
dart pub add --dev dart_pre_commit
```
Run the following command to install the package:
```bash
dart run lib/tools/setup_git_hooks.dart
```

To update the yaml file, run the following command:
```bash
flutter pub upgrade --major-versions --tighten
```

## 2. Design System

I have created a very small design system for this project, which contains color tokens, fonts, sizing tokens, icons etc. I purposely didn't create any ui components in the design system, trying to make this as simple as possible.
The app also contains a dark theme and light theme thanks to the design system.

## 3. Architecture Overview

The architecture of this Flutter application follows the **Clean Architecture principles**, which promotes separation of concerns. For the sake of simplicity the application uses a monolithic structure with some aspects of multi-modular architecture. Multi-modularization can be achieved relatively easily with the current architecture.

The architecture for the features consists of the following layers:

### Presentation Layer

- **UI Components**: Implement the user interface using Flutter widgets.
- **BLoCs**: Manage the presentation logic and interacts with the domain layer.

### Domain Layer
- **Entities**: Represent the core data models and business entities.
- **Repositories**: Defining the Repositories interface for the data layer to implement.

### Data Layer

- **Repositories**: Implements the Repository Interface from the domain layer and fulfilling its API.
- **Data Sources**: Provide concrete implementations for interacting with remote and local data sources.
- **Mappers**: Convert data between different layers of the application, such as from raw data obtained from external sources to domain entities.
- **DTO**: Contain data models representing the structure of data fetched from external sources.]()

## 4. Trade Off

The application was developed in a very short time, so there are some places which can be improved.
- There are a few inconsistencies throughout the project.
- A collection-document based local-data store would have been a better choice, due to time constraints I used sqflite.
- Isolates could be used to process data mapping

## 5. Final Notes

#### Doing this assignment was fun!

With my solution I tried to be pragmatic and strike a good balance between simulating production-ready code and keeping it simple.
There are still many functionalities, ux improvements and tests that could be added but were left out for the sake of simplicity.

#### Thank you for taking the time to review and read through :)

I would be more than happy to discuss the solution further with you.
