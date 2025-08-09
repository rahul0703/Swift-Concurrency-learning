
# iOS L4 Interview Questions & Answers

This document contains over 60 iOS-specific interview questions and answers, ideal for candidates with 3–4 years of experience.

---

## 📱 UIKit & SwiftUI

**1. How does the responder chain work in UIKit?**  
The responder chain is a hierarchy through which events are passed until an appropriate object handles them. It starts with the first responder and moves up through the view hierarchy to the view controller, window, and application.

**2. What’s the difference between `layoutSubviews`, `setNeedsLayout`, and `layoutIfNeeded`?**  
- `layoutSubviews`: Override to manually layout subviews.
- `setNeedsLayout`: Marks the view as needing layout; layout is deferred.
- `layoutIfNeeded`: Immediately forces layout if marked.

**3. How does SwiftUI’s rendering lifecycle differ from UIKit’s?**  
SwiftUI is declarative and automatically re-renders views based on state changes. UIKit requires explicit updates via lifecycle methods.

**4. How would you implement a reusable custom view in SwiftUI?**  
```swift
struct CustomButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
```

**5. When does SwiftUI re-render a view?**  
When a bound state changes (`@State`, `@Binding`, `@ObservedObject`, etc.).

**6. What’s the role of `@State`, `@Binding`, `@ObservedObject`, and `@EnvironmentObject`?**  
- `@State`: Local, simple value.
- `@Binding`: Two-way binding to `@State`.
- `@ObservedObject`: External data model.
- `@EnvironmentObject`: Shared app-wide data.

**7. How do you handle view transitions in SwiftUI?**  
With `.transition()` and `.animation()` modifiers.

**8. How would you debug layout issues in SwiftUI?**  
Use Xcode previews, `overlay()`, `border()`, and `print()` in `body`.

**9. How does diffing work in SwiftUI's `List`?**  
SwiftUI compares identifiable elements and updates only changed views.

**10. What's the SwiftUI equivalent of `UITableViewDiffableDataSource`?**  
SwiftUI `List` with `Identifiable` and `ForEach`.

---

## 🧠 Memory Management

**11. What is ARC and how does it work in Swift?**  
Automatic Reference Counting deallocates objects when no strong references remain.

**12. Explain retain cycles with an example.**  
Two objects strongly reference each other, preventing deallocation.

**13. What is a weak reference and when would you use it?**  
A reference that does not increase retain count, used to break retain cycles.

**14. How does memory management differ between Swift structs and classes?**  
Structs are value types (copied), classes are reference types (shared memory).

**15. Why is `[weak self]` used in closures?**  
To avoid retaining `self` and creating a cycle between the closure and object.

**16. How do you detect and fix memory leaks?**  
Use Instruments’ Leaks tool or Xcode’s memory graph debugger.

---

## 🏗 App Architecture

**17. Compare MVC, MVVM, and VIPER. When would you use each?**  
- MVC: Simpler apps.
- MVVM: Moderate complexity, good SwiftUI fit.
- VIPER: Large-scale, modular apps.

**18. How would you structure a SwiftUI project for testability?**  
Separate ViewModels, use dependency injection, follow MVVM.

**19. What’s a Coordinator pattern?**  
Decouples navigation from view controllers; improves modularity.

**20. How would you organize navigation logic in SwiftUI?**  
Using navigation stacks or custom routers via `NavigationLink`.

**21. How do you decouple networking from UI?**  
Use a service layer and inject it into ViewModels.

---

## 🔌 Networking

**22. How would you implement an API layer using `URLSession`?**  
Encapsulate logic in a service:
```swift
func fetch(from url: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
```

**23. How does `URLCache` work in iOS?**  
Caches HTTP responses using headers, reducing redundant network calls.

**24. How would you use Combine for reactive network calls?**  
Use `dataTaskPublisher`, `map`, `decode`, and `sink`.

**25. How do you handle background downloads?**  
Use `URLSessionDownloadTask` with background configuration.

**26. What is the difference between `async/await` and Combine?**  
- `async/await`: Structured concurrency.
- Combine: Reactive streams.

---

## 🧪 Testing

**27. How would you test a SwiftUI view?**  
Use snapshot testing or `XCTAssert` on rendered views in test cases.

**28. What’s the difference between unit tests, UI tests, and snapshot tests?**  
- Unit: Smallest logic units.
- UI: Interact with app UI.
- Snapshot: Visual regression.

**29. How do you mock network calls in tests?**  
Inject mock `URLProtocol` or mock services.

**30. Write a test case for `LoginViewModel`.**  
```swift
func testLoginSuccess() {
    let mockService = MockAuthService()
    let vm = LoginViewModel(service: mockService)
    vm.login(username: "test", password: "1234")
    XCTAssertTrue(vm.isLoggedIn)
}
```

---

## 📦 Concurrency

**31. Difference between GCD and `OperationQueue`?**  
- GCD: Simple, fast, functional.
- OperationQueue: Cancellable, dependencies.

**32. How does `MainActor` work?**  
Ensures code runs on the main thread:
```swift
@MainActor
func updateUI() { ... }
```

**33. Use of `Task`, `async let`, `await`, `TaskGroup`?**  
- `Task`: Fire-and-forget.
- `async let`: Concurrent child tasks.
- `await`: Suspend execution.
- `TaskGroup`: Structured parallelism.

**34. Run 3 tasks in parallel and await all.**  
```swift
async let a = fetchA()
async let b = fetchB()
async let c = fetchC()
let results = await (a, b, c)
```

**35. How to cancel a running async task?**  
Keep a reference and call `.cancel()` on the `Task`.

---

## 📍 Persistence

**36. Compare Core Data, UserDefaults, FileManager.**  
- Core Data: Complex models.
- UserDefaults: Small key-values.
- FileManager: Manual file I/O.

**37. Use Codable to save/load data?**  
```swift
let data = try JSONEncoder().encode(model)
try data.write(to: url)
let model = try JSONDecoder().decode(Model.self, from: data)
```

**38. What is `NSPersistentContainer`?**  
Core Data stack wrapper that simplifies context and store setup.

**39. Core Data performance tips?**  
Batch fetching, indexing, avoid faulting large trees.

**40. Write a UserDefaults wrapper.**  
```swift
struct Settings {
    static var token: String? {
        get { UserDefaults.standard.string(forKey: "token") }
        set { UserDefaults.standard.setValue(newValue, forKey: "token") }
    }
}
```

---

## 🔒 Security

**41. How to store sensitive tokens?**  
Use Keychain, never UserDefaults.

**42. How does Keychain work?**  
Encrypted secure storage managed by iOS APIs.

**43. What’s App Transport Security?**  
Enforces HTTPS; improves security.

**44. Manage permissions gracefully?**  
Check `authorizationStatus`, show rationale dialogs.

---

## 💬 Notifications

**45. `UNUserNotificationCenter` vs legacy APIs?**  
Modern, supports categories, actions, better scheduling.

**46. Background App Refresh vs Push Notifications?**  
- Background App Refresh: Scheduled, limited.
- Push: External, reliable.

**47. Schedule and handle local notifications?**  
Use `UNMutableNotificationContent`, `UNTimeIntervalNotificationTrigger`, and add to center.

---

## 🧰 Debugging

**48. Profile memory leaks in Instruments?**  
Use Leaks and Allocations instruments.

**49. Common Instruments?**  
Time Profiler, Leaks, Allocations, Energy Log.

**50. Inspect view hierarchy at runtime?**  
Use Debug View Hierarchy in Xcode or `po` in LLDB.

---

## 🧩 System Design

**51. Design image cache with memory + disk.**  
Use `NSCache` for memory, disk with `FileManager`.

**52. Offline-first Notes app?**  
Use Core Data + background sync + conflict resolution.

**53. Implement debounce on search bar.**  
Use Combine or `DispatchWorkItem` with a delay.

**54. Download manager with pause/resume?**  
Track progress, use `resumeData`, background sessions.

**55. Support deep links?**  
Handle via `application(_:open:options:)` or `onOpenURL`.

**56. Build analytics framework?**  
Buffer events, store locally, flush periodically.

---

## 🧾 Code Snippet

**57. Fix retain cycle:**
```swift
closure = { [weak self] in
    guard let self = self else { return }
    print(self)
}
```

**58. Bug in Combine pipeline?**  
Missing `.sink(receiveCompletion:receiveValue:)` or `.store(in:)`.

**59. Convert to async/await:**
```swift
func fetchData() async -> Data? {
    await withCheckedContinuation { continuation in
        fetchData { data in
            continuation.resume(returning: data)
        }
    }
}
```

**60. SwiftUI tap counter reset after 5:**
```swift
struct TapCounter: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Taps: \(count)")
            Button("Tap me") {
                count += 1
                if count >= 5 { count = 0 }
            }
        }
    }
}
```
