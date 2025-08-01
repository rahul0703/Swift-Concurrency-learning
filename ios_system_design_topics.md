# iOS System Design Topics for 4–5 YOE Engineers (MAANG/PayPal/Uber)

This document outlines the key system design topics iOS engineers with 4–5 years of experience should master for interviews at companies like MAANG, PayPal, Uber, and similar top-tier tech organizations.

## 🔷 iOS-Specific System Design Topics

### 1. Modular Architecture
- Clean Architecture
- VIPER, MVVM, MVC: comparisons and tradeoffs
- Feature modules, dynamic frameworks
- Code separation: presentation, business logic, data layer

### 2. Scalability in Mobile Apps
- Designing scalable and maintainable iOS apps
- Handling large codebases (modular monoliths)
- Dependency injection (Resolver, Swinject)

### 3. Offline Support & Caching
- CoreData / SQLite / Realm
- NSCache, URLCache
- Offline-first architecture
- Sync strategies: last-write-wins, conflict resolution

### 4. Networking & Data Layer
- URLSession, Alamofire
- Retry policies, exponential backoff
- Networking architecture (interceptors, logging)
- GraphQL vs REST

### 5. Concurrency & Thread Safety
- GCD and Operation Queues
- Swift Concurrency: async/await, actors
- Avoiding race conditions and deadlocks

### 6. App Performance and Optimization
- App launch time improvements
- Instruments for profiling
- Memory management
- Reducing binary size and build time

### 7. Feature Design End-to-End
- Messaging, ride tracking, in-app purchases
- App lifecycle, background execution, state handling

## 🔷 Platform-Level Design Topics

### 8. Push Notifications & Deep Linking
- APNs, FCM
- Universal Links, custom schemes
- Background fetch, notification handling

### 9. Security in Mobile Apps
- Keychain, biometrics
- Secure local storage
- SSL pinning, jailbreak detection

### 10. Testing & CI/CD
- Unit, UI, snapshot testing (XCTest, Quick/Nimble)
- CI tools: GitHub Actions, Bitrise
- Fastlane automation

## 🔷 System Design General (Cross-Platform or Backend-Aware)

### 11. End-to-End Mobile System Architecture
- Frontend ↔️ Backend interaction
- Auth flows: OAuth2, token refresh
- Monitoring, crash reporting (Firebase, Sentry)

### 12. Sync Engines
- Local/remote data syncing
- Silent notifications, background tasks

### 13. Feature Flags / Remote Config
- Feature toggles (LaunchDarkly, Firebase Remote Config)
- Progressive rollouts, experimentation

### 14. Analytics and Event Tracking
- Event modeling, batching
- Tools: Mixpanel, Segment, Firebase Analytics

### 15. Multi-Platform Support
- Shared logic (SwiftPM, KMM)
- iOS vs Android considerations

## 🔷 Behavioral & Collaboration Topics

### 16. Code Review and Architecture Decisions
- Justifying design decisions
- Writing ADRs/RFCs

### 17. Cross-Functional Collaboration
- Working with backend and product teams
- UX and performance tradeoffs

### 18. Engineering Practices at Scale
- Mentoring and design guidelines
- Managing tech debt and refactors

## 🔷 Common Interview Design Prompts

- Design a chat system with offline and sync support
- Design a ride-tracking app for drivers/passengers
- Design a real-time notification service
- Design a secure payment flow for a mobile wallet
- Design an e-commerce app with recommendation and search

---

Mastering these topics will prepare you for system design interviews at high-caliber companies in the mobile engineering space.
