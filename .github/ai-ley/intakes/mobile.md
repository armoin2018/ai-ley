---
templateType: intake
category: mobile
version: 1.0.0
author: AI-LEY
created: 2025-11-09T00:00:00.000000
description: Interactive intake template for mobile application projects
---

# Mobile Application Project Intake

## Project Overview

### Q1: App Name

**Question**: What is the name of your mobile application?
**Type**: text
**Required**: yes

### Q2: App Description

**Question**: Provide a brief description of the mobile app (1-2 paragraphs). What problem does it solve and who are the target users?
**Type**: textarea
**Required**: yes

### Q3: App Category & Goals

**Question**: What category does the app fall into and what are the primary goals?
**Type**: list
**Required**: yes
**App Categories**:

- Social networking
- E-commerce/Shopping
- Productivity/Utilities
- Health & Fitness
- Entertainment/Media
- Education/Learning
- Finance/Banking
- Travel/Navigation
- Food & Drink
- Lifestyle
- Business/Enterprise
- Gaming

**Goals Examples**:

- Increase user engagement
- Generate revenue through in-app purchases
- Provide on-the-go access to services
- Improve customer experience
- Replace manual processes
- Enable offline capabilities
- Drive brand awareness

## Platform & Technology

### Q4: Target Platforms

**Question**: Which mobile platforms will the app support?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- iOS (iPhone)
- iOS (iPad)
- Android (Phone)
- Android (Tablet)
- Cross-platform (iOS + Android)

### Q5: Development Approach

**Question**: What development approach will be used?
**Type**: single-select
**Required**: yes
**Suggestions**:

- Native iOS (Swift/SwiftUI)
- Native Android (Kotlin/Jetpack Compose)
- Cross-platform (React Native)
- Cross-platform (Flutter)
- Cross-platform (Xamarin/.NET MAUI)
- Cross-platform (Ionic/Capacitor)
- Hybrid (Cordova/PhoneGap)
- Progressive Web App (PWA)

### Q6: Technology Stack

**Question**: What specific technologies and frameworks will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

**Common Mobile Stack Options**:

Frontend/UI:

- React Native
- Flutter
- Swift/SwiftUI
- Kotlin/Jetpack Compose
- Xamarin
- Ionic
- NativeScript

Backend/API:

- Firebase
- AWS Amplify
- Supabase
- Node.js/Express
- Python/FastAPI
- .NET Core
- GraphQL

Database/Storage:

- SQLite (local)
- Realm
- Core Data (iOS)
- Room (Android)
- Firebase Firestore
- AWS DynamoDB
- PostgreSQL (backend)

State Management:

- Redux/Redux Toolkit
- MobX
- Provider (Flutter)
- BLoC (Flutter)
- Riverpod
- Zustand

### Q7: Minimum OS Versions

**Question**: What are the minimum supported OS versions?
**Type**: text
**Required**: yes
**Format**:

```
iOS: [version, e.g., iOS 14.0+]
Android: [version, e.g., Android 8.0 (API 26)+]
```

**Considerations**:

- Market share of OS versions
- Feature availability in older versions
- Maintenance burden

## Features & Functionality

### Q8: Core Features

**Question**: What are the essential features that must be delivered in the initial release?
**Type**: list
**Required**: yes
**Common Mobile Features**:

- User onboarding flow
- Authentication (login/signup)
- User profile management
- Push notifications
- In-app messaging/chat
- Camera/photo capture
- Photo/video gallery
- Location services/maps
- Barcode/QR code scanning
- Offline mode
- Data synchronization
- Search functionality
- Filters and sorting
- Social sharing
- In-app purchases/payments
- Rating and reviews
- Settings and preferences
- Help/support section

### Q9: Authentication & User Management

**Question**: What authentication methods and user management features are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Email/Password authentication
- Social login (Google, Apple, Facebook)
- Phone number authentication (SMS)
- Biometric authentication (Face ID, Touch ID, fingerprint)
- PIN/Passcode
- OAuth 2.0
- Single Sign-On (SSO)
- Multi-factor authentication (MFA)
- Session management
- Password reset
- Account deletion
- User profile editing

### Q10: Offline Capabilities

**Question**: What offline functionality is required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- View cached content offline
- Create/edit content offline
- Offline data persistence
- Background sync when online
- Conflict resolution for offline edits
- Offline-first architecture
- Download for offline use
- Queue actions for later sync
- Offline mode indicator

### Q11: Push Notifications

**Question**: What push notification capabilities are needed?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Transactional notifications (order updates, etc.)
- Marketing/promotional notifications
- Real-time alerts
- Scheduled notifications
- Rich notifications (images, actions)
- Deep linking from notifications
- Notification preferences/settings
- Badge count updates
- Silent/background notifications
- Geofencing notifications
- Multi-platform notification management (FCM, APNs)

## Device Features & Integrations

### Q12: Device Hardware Features

**Question**: Which device hardware features will the app utilize?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Camera (photo/video capture)
- Microphone (audio recording)
- GPS/Location services
- Accelerometer/Gyroscope
- Compass
- Bluetooth
- NFC
- Biometric sensors (fingerprint, Face ID)
- Proximity sensor
- Ambient light sensor
- Haptic feedback/vibration
- Health sensors (HealthKit, Google Fit)

### Q13: Third-Party Integrations

**Question**: What third-party services or SDKs need to be integrated?
**Type**: list
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/integrations.md`
**Allow Custom**: yes
**Common Mobile Integrations**:

- Analytics (Firebase Analytics, Mixpanel, Amplitude)
- Crash reporting (Crashlytics, Sentry, Bugsnag)
- Push notifications (Firebase, OneSignal, Pusher)
- Maps (Google Maps, Apple Maps, Mapbox)
- Payment processing (Stripe, PayPal, Apple Pay, Google Pay)
- Social media SDKs (Facebook, Twitter, Instagram)
- Authentication (Firebase Auth, Auth0, Clerk)
- Cloud storage (Firebase Storage, AWS S3, Cloudinary)
- In-app purchases (RevenueCat, Apple StoreKit, Google Play Billing)
- Customer support (Intercom, Zendesk, Freshchat)
- A/B testing (Firebase Remote Config, Optimizely)
- Deep linking (Branch, AppsFlyer, Adjust)

### Q14: Backend/API Requirements

**Question**: What backend and API requirements are needed?
**Type**: textarea
**Required**: yes
**Suggestions**:

- RESTful API
- GraphQL API
- WebSocket for real-time features
- File upload/download endpoints
- API authentication (JWT, OAuth)
- Rate limiting requirements
- Backend hosting (cloud provider)
- Database requirements
- CDN for media assets
- Background job processing

## User Experience & Design

### Q15: Design System & UI

**Question**: What are the UI/UX requirements and design considerations?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Design system or UI library
- Platform-specific design (iOS Human Interface Guidelines, Material Design)
- Custom branding and themes
- Dark mode support
- Accessibility requirements (VoiceOver, TalkBack, font scaling)
- Internationalization/localization
- Right-to-left (RTL) language support
- Responsive layouts for different screen sizes
- Tablet-optimized layouts
- Animation and transitions

### Q16: Accessibility Requirements

**Question**: What accessibility features must be supported?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Screen reader support (VoiceOver, TalkBack)
- Dynamic type/font scaling
- High contrast mode
- Color blindness considerations
- Voice control support
- Haptic feedback for visual impairments
- Closed captions for video
- Alternative text for images
- Keyboard navigation (for tablets)
- WCAG 2.1 compliance level (A, AA, AAA)

### Q17: Localization & Internationalization

**Question**: What languages and regions will be supported?
**Type**: list
**Required**: yes
**Format**: List primary language(s) and any additional languages
**Considerations**:

- Text translation
- Date/time formatting
- Currency formatting
- Number formatting
- Right-to-left (RTL) layouts
- Region-specific content
- Local payment methods
- Cultural considerations

## Performance & Quality

### Q18: Performance Requirements

**Question**: What are the performance targets and expectations?
**Type**: textarea
**Required**: yes
**Format**:

```
App Launch Time: [target, e.g., < 2 seconds]
Screen Transition: [target, e.g., < 300ms]
API Response Handling: [target, e.g., < 1 second]
Frame Rate: [target, e.g., 60fps]
Battery Impact: [acceptable level]
Memory Usage: [constraints]
App Size: [target, e.g., < 50MB]
Network Efficiency: [data usage considerations]
```

### Q19: App Size & Distribution

**Question**: What are the app size and distribution requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Target app size (iOS App Store limit: 4GB, Android: varies)
- Download size vs install size
- App thinning/slicing strategies
- Asset optimization requirements
- Over-the-air (OTA) updates
- App Store/Play Store distribution
- Enterprise distribution
- Beta testing (TestFlight, Firebase App Distribution)
- Staged rollouts

## Security & Privacy

### Q20: Security Requirements

**Question**: What security measures must be implemented?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Secure data storage (Keychain, KeyStore)
- Encryption at rest
- Encryption in transit (TLS/SSL)
- Certificate pinning
- Secure authentication token storage
- Jailbreak/root detection
- Code obfuscation
- Reverse engineering protection
- Secure API communication
- Input validation
- Secure file handling
- Biometric authentication
- Session timeout
- Security audits

### Q21: Privacy & Data Protection

**Question**: What privacy and data protection measures are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Privacy policy and terms of service
- User consent management
- Data collection transparency
- Data minimization practices
- User data deletion/export
- GDPR compliance
- CCPA compliance
- COPPA compliance (if targeting children)
- App Tracking Transparency (iOS)
- App privacy labels (App Store)
- Android privacy manifest
- Third-party SDK data usage disclosure
- Analytics opt-out

## Team & Resources

### Q22: Team Composition

**Question**: What roles and expertise are available on the team?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Common Roles**:

- iOS Developer
- Android Developer
- React Native Developer
- Flutter Developer
- Mobile UI/UX Designer
- Backend Developer
- QA/Test Engineer
- DevOps Engineer
- Product Manager
- Mobile Architect

### Q23: Required Instructions

**Question**: What technical guidance and best practices will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)
**Common Instructions**:

- iOS development best practices
- Android development best practices
- React Native best practices
- Flutter best practices
- Mobile security guidelines
- App Store submission guidelines
- Performance optimization
- Testing strategies
- Code signing and certificates

## Testing & Quality Assurance

### Q24: Testing Requirements

**Question**: What testing strategies and coverage are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Unit tests (target coverage %)
- Integration tests
- UI/E2E tests (Detox, Appium, XCUITest, Espresso)
- Manual testing
- Device testing matrix (which devices?)
- OS version testing matrix
- Performance testing
- Battery drain testing
- Network condition testing (slow 3G, 4G, 5G, offline)
- Security testing
- Accessibility testing
- Localization testing
- Beta testing program

### Q25: Device Coverage

**Question**: What devices and configurations must be tested?
**Type**: textarea
**Required**: yes
**Format**:

```
iOS Devices:
- iPhone models: [list key models]
- iPad models: [if applicable]

Android Devices:
- Flagship devices: [Samsung Galaxy S-series, Google Pixel, etc.]
- Mid-range devices: [specify]
- Screen sizes: [small, medium, large]
- OS versions: [range]
```

## App Store & Distribution

### Q26: App Store Requirements

**Question**: What are the app store submission and compliance requirements?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Apple App Store submission
- Google Play Store submission
- App Store screenshots and previews
- App Store descriptions and metadata
- App icons (all required sizes)
- Age rating requirements
- Content rating
- Privacy policy URL
- Terms of service
- App review guidelines compliance
- Alternative app stores (Amazon, Samsung Galaxy Store)

### Q27: Monetization Strategy

**Question**: What is the app's monetization model?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Free (no monetization)
- In-app purchases (consumable, non-consumable, subscriptions)
- Subscription model (monthly, yearly)
- Ads (banner, interstitial, rewarded video)
- Freemium model
- Paid download
- Enterprise licensing
- Sponsorships/partnerships

## Constraints & Timeline

### Q28: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: textarea
**Required**: yes
**Format**:

```
MVP/Beta: [date]
App Store Submission: [date]
Public Launch: [date]
Key Milestones:
- Milestone 1: [description] - [date]
- Milestone 2: [description] - [date]
```

### Q29: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no

### Q30: Technical Constraints

**Question**: Are there any technical, platform, or infrastructure constraints?
**Type**: textarea
**Required**: no
**Suggestions**:

- Must integrate with existing systems
- Legacy backend compatibility
- Device capability requirements
- Network bandwidth limitations
- Offline-first requirements
- Existing authentication system integration
- Corporate security policies

## Success Metrics

### Q31: Key Performance Indicators

**Question**: How will app success be measured? What are the key metrics?
**Type**: list
**Required**: yes
**Suggestions**:

- Downloads/Installs
- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- User retention (Day 1, Day 7, Day 30)
- Session length
- Session frequency
- Feature adoption rate
- Conversion rate (if applicable)
- In-app purchase revenue
- Ad revenue
- App Store rating
- Crash-free rate
- App Store/Play Store ranking
- Churn rate
- Customer Lifetime Value (LTV)

### Q32: Success Criteria

**Question**: What specific outcomes would indicate the project is successful?
**Type**: textarea
**Required**: yes
**Examples**:

- "Reach 100,000 downloads in first 6 months"
- "Maintain 4.5+ star rating on both stores"
- "Achieve 40% Day 7 retention rate"
- "Generate $X in monthly revenue"
- "99.5% crash-free sessions"
- "Featured in App Store/Play Store"
