[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# Taskerly

A visually appealing and intuitive task management app that with beautiful UI/UX, mobile development proficiency, and attention to detail.

## Features

- [x] Create a dashboard view showing task statistics (e.g., completed vs. pending tasks).
- [x] Allow users to create, read, update, and delete tasks.
- [x] Add the ability to set reminders for tasks.
- [x] Add haptic feedback for user interactions.
- [x] Implement task categorization (work, personal, etc.).
- [x] Implement data for persistent storage.
- [x] Implement drag-and-drop functionality for reordering tasks.

## Requirements

- iOS 17.0+
- Xcode 15.0

## Design Decisions and Rationale

1. Architecture: Clean Swift VIPER

   - Decision: Taskerly will use the Clean Swift VIPER architecture.
   - Rationale: Clean Swift VIPER offers a clear separation of concerns by splitting the app into five layers: View, Interactor, Presenter, Entity, and Router. This ensures that each component of the app has a well-defined responsibility, leading to better maintainability, scalability, and testability. By adopting this architecture, Taskerly will be more modular, making it easier to implement new features, debug, and manage complex UI/UX interactions.

2. Database: SwiftData

   - Decision: SwiftData will be used as the database layer for Taskerly.
   - Rationale: SwiftData is Apple’s modern data storage solution, offering seamless integration with Swift and iOS frameworks. It provides a type-safe, high-performance, and easy-to-use API for managing data. By leveraging SwiftData, Taskerly will benefit from efficient data management and the ability to scale with increasing data needs without compromising performance. Additionally, it ensures compatibility with the latest iOS features and best practices.

3. UI/UX Design: Figma Template

   - Decision: A Figma template will be used as the foundation for Taskerly’s UI/UX design.
   - Rationale: Figma is a powerful design tool that allows for rapid prototyping, collaboration, and iteration. By starting with a Figma template, the design process will be more efficient, ensuring consistency and a cohesive visual language throughout the app. The template will provide a polished base that can be customized to align with Taskerly’s branding and user experience goals, leading to a visually appealing and user-friendly interface.

4. Platform Support: iOS 17+

   - Decision: Taskerly will support iOS 17 and above.
   - Rationale: By focusing on iOS 17+, Taskerly can take full advantage of the latest iOS features, performance improvements, and design conventions. This ensures that the app remains future-proof, offering users the best possible experience. Additionally, targeting the latest iOS version allows for the implementation of modern SwiftUI components, haptic feedback, and other advanced features that contribute to a more engaging and responsive user experience.

5. User Interface & Experience:

   - Decision: The UI will be crafted to be both visually appealing and highly intuitive.
   - Rationale: A task management app like Taskerly requires a clean, uncluttered interface that allows users to focus on their tasks without unnecessary distractions. The design will incorporate a minimalist aesthetic with intuitive navigation, ensuring users can easily manage their tasks. Special attention will be given to details such as animations, transitions, and feedback mechanisms to enhance the user experience and make the app feel responsive and alive.

6. Mobile Development Proficiency

   - Decision: Taskerly will be developed with a focus on mobile development best practices.
   - Rationale: Given the mobile-first nature of the app, it’s essential to ensure smooth performance, quick load times, and a responsive design that works seamlessly across various iPhone models. The app will leverage Swift’s powerful capabilities to optimize for performance while maintaining a sleek and modern design, ensuring a balance between functionality and aesthetics.

7. Attention to Detail

   - Decision: Every aspect of the app, from micro-interactions to color schemes, will be carefully considered.
   - Rationale: Attention to detail is crucial in creating an app that feels polished and professional. Small details such as iconography, button responsiveness, and even the choice of typography can significantly impact the user experience. By meticulously refining these details, Taskerly will stand out as a premium task management solution that delights users and keeps them engaged.
  
### Conclusion

The combination of Clean Swift VIPER architecture, SwiftData, a well-designed Figma template, and a focus on modern iOS features ensures that Taskerly will be a robust, scalable, and user-friendly app. The decisions made in the development of Taskerly are guided by the need for a high-quality, intuitive, and visually appealing task management experience that leverages the latest in mobile development technologies and design practices.

## Future improvements

- [ ] Create a visually appealing onboarding experience for first-time users.
- [ ] Allow filter tasks by category.
- [ ] Add unit & ui tests.
- [ ] Add a launch screen.
- [ ] Add support for subtasks with an expandable/collapsible UI.
- [ ] Add support for repeating tasks.
- [ ] Add support for clould data storing.
- [ ] Add support for authentication using Firebase Auth.
- [ ] Add support for app locking with Face ID / Touch ID / Passcode.

## Contribute

We would love you for the contribution to **Taskerly**, check the ``LICENSE`` file for more info.

## Meta

Duc Nguyen – ducnh.2012@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/duc-ios/EarthSandwich](https://github.com/duc-ios/EarthSandwich)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
