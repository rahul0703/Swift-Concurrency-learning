# Swift Concurrency - README

This document summarizes key topics in Swift Concurrency, suitable for interviews and practical use.

---

## 🔷 Topics in Swift Concurrency

### 1. Structured Concurrency
Swift's model for organizing concurrent code in a tree-like structure that scopes child tasks to their parent, improving safety and clarity.

### 2. `async`/`await`
Syntax used to define and call asynchronous functions in a linear, readable way, replacing completion handlers.

### 3. `Task`
A lightweight, concurrent unit of work that can run asynchronously and in parallel with other tasks.

### 4. Task Cancellation
Allows a running task to be cancelled cooperatively using the `Task.isCancelled` check or `try Task.checkCancellation()`.

### 5. `TaskGroup`
Used to run multiple child tasks in parallel and wait for all of them to complete, useful for parallelizing work.

### 6. `DetachedTask`
Creates a task that is not bound to the current actor or task hierarchy, used for background and independent work.

### 7. `MainActor`
Ensures code runs on the main thread, primarily for updating UI safely in SwiftUI or UIKit.

### 8. `@MainActor`
An attribute to mark a function, property, or type as always running on the main actor (main thread).

### 9. `Actor`
A reference type that protects its mutable state from data races by ensuring only one task can access it at a time.

### 10. `@actorIndependent`
Marks parts of an actor that can be safely accessed from outside without actor isolation enforcement.

### 11. `Sendable`
A protocol ensuring data passed between concurrency domains (tasks/actors) is safe to use without causing data races.

### 12. `@Sendable`
Used to mark closures as safe for concurrency, enforcing capture of only `Sendable` types or immutables.

### 13. Unstructured Concurrency
Concurrency initiated via detached or top-level `Task` that is not bound to a parent or structured hierarchy.

### 14. Concurrency and Error Handling
Swift’s async/await model integrates with `try`/`catch` to handle thrown errors in asynchronous functions.

### 15. Async Sequences & Streams
Enables modeling of values that arrive over time using `AsyncSequence`, `AsyncStream`, and `AsyncThrowingStream`.

### 16. Priorities and Quality of Service
You can assign priorities (e.g., `.userInitiated`, `.background`) to tasks, affecting their execution scheduling.

---

## 🔷 Pre-Concurrency Asynchronous Patterns

### 1. Completion Handlers
Functions that accept a closure to be called when work finishes asynchronously.

```swift
func fetchData(completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        completion("Hello")
    }
}
```

### 2. Grand Central Dispatch (GCD)
Low-level API for managing concurrent queues and threads.

```swift
DispatchQueue.global().async {
    // background work
    DispatchQueue.main.async {
        // update UI
    }
}
```

### 3. OperationQueue
A higher-level abstraction over GCD for managing and canceling work.

```swift
let queue = OperationQueue()
queue.addOperation {
    // async task
}
```

### 4. Delegation
Used widely in UIKit for async communication between objects (e.g., URLSessionDelegate).

---

## 🔷 Comparison: Pre-Concurrency vs Swift Concurrency

| Feature                   | Pre-Concurrency                         | Swift Concurrency              |
|---------------------------|------------------------------------------|--------------------------------|
| Async function syntax     | Completion Handlers (`@escaping`)       | `async`/`await`                |
| Error handling            | `Result<T, Error>` or multiple params   | `throws` + `try`/`catch`       |
| Cancellation              | Manual flags or NSOperations            | Built-in with `Task` API       |
| Readability               | Nested closures, harder to follow       | Linear, top-down flow          |
| Thread safety             | Manual (queues, locks)                  | `Actor` model for isolation    |
| Sequencing async tasks    | Callback chains or Dispatch Groups      | `async let`, `TaskGroup`       |

---

Mastering both legacy and modern async patterns is essential for working in real-world iOS codebases and acing interviews.
