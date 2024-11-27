# Dragon's Crown Skill Build Planner

## Overview
A comprehensive skill build calculator and planning tool for Dragon's Crown, featuring an intuitive UI for character skill point allocation, build sharing, and a built-in Rune Matcher minigame. This application helps players optimize their character builds and practice rune combinations.

## Features
* Interactive Skill Point Calculator
* Build Export & Sharing
* Rune Matcher Training Game
* Character Stats Visualization
* Quest & Recommendation System
* Detailed Skill Information
* Audio & Visual Feedback
* Sprite Animations
* Particle Effects
* Strict Mode Toggle
* Mobile Responsive Design

## Technology Stack

### Backend
* Java Spring Boot
* Spring Data JPA
* MySQL Database
* Gradle Build System
* Custom Image Proxy Service

### Frontend
* Angular
* TypeScript
* Particle.js
* Custom Audio System
* Responsive Animations
* Interactive UI Components
* Custom Directives

## Project Structure

```
├── DB/                           # Database files & schema
├── DragonsCrown/                 # Spring Boot Backend
│   ├── src/main/java
│   │   ├── controllers/         # REST endpoints
│   │   ├── services/           # Business logic
│   │   ├── repositories/       # Data access
│   │   └── security/           # Basic security
│   └── resources/              # Static assets
│       └── assets/             # Audio & graphics
├── JPADragonsCrown/            # JPA Entity Project
│   └── src/main/java
│       └── entities/           # Data models
└── ngDragonsCrown/             # Angular Frontend
├── src/app
│   ├── components/         # UI components
│   ├── services/          # Data services
│   ├── models/           # TypeScript interfaces
│   ├── directives/       # Custom directives
│   └── pipes/            # Calculation pipes
```

## Setup & Installation

### Prerequisites
* Java 11+
* Node.js & npm
* MySQL
* Gradle

### Database Setup
1. Create MySQL database
2. Run schema script from DB folder
3. Configure connection in application.properties

### Backend Setup
1. Clone repository
2. Navigate to DragonsCrown directory
3. Build project:
   ```
   ./gradlew build
   ```
4. Run application:
   ```
   ./gradlew bootRun
   ```

### Frontend Setup
1. Navigate to ngDragonsCrown
2. Install dependencies:
   ```
   npm install
   ```
3. Start development server:
   ```
   ng serve
   ```

## Key Features Implementation

### Skill Calculator
* Dynamic Point Allocation
* Real-time Stat Updates
* Skill Dependencies
* Build Validation
* Export/Share Functionality

### Rune Matcher
* Memory Training Game
* Audio Feedback
* Visual Effects
* Progress Tracking
* Practice Mode

### UI/UX Features
* Character Sprites
* Particle Effects
* Sound Effects
* Responsive Design
* Toast Notifications
* Loading Screens
* Parallax Effects

### Core Systems
* Skill Point Calculation
* Stat Scaling
* Build Sharing
* Audio Management
* Image Proxy Service
* Strict Mode Logic

## Core Entities
* PlayerClass
* Skills
* SkillDetails
* ClassStats
* StatScaling
* Quests
* Recommendations

## Testing
* Backend: JUnit tests for entities & services
* Frontend: Karma & Jasmine for components & services

## Contributing
1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Submit pull request

## License
All rights reserved

## Contact
[Your contact information]