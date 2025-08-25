# API Handling Methods in Swift

## 1. Delegates
**How it works:**  
You define a protocol with callback methods. The API manager calls these methods once a network response is received.  

**Pros:**  
- Lightweight, memory-efficient.  
- Clear separation of responsibilities.  

**Cons:**  
- Boilerplate-heavy.  
- One-to-one relationship (hard to broadcast to multiple listeners).  

**Example:**
```swift
protocol APIServiceDelegate: AnyObject {
    func didReceiveData(_ data: Data)
    func didFailWithError(_ error: Error)
}

class APIService {
    weak var delegate: APIServiceDelegate?

    func fetchData() {
        URLSession.shared.dataTask(with: URL(string: "https://api.example.com")!) { data, _, error in
            if let error = error {
                self.delegate?.didFailWithError(error)
            } else if let data = data {
                self.delegate?.didReceiveData(data)
            }
        }.resume()
    }
}
```

---

## 2. Completion Handlers (Closures)
**How it works:**  
Pass a closure into the API function that executes when the result is ready.  

**Pros:**  
- Lightweight and inline.  
- Easy to chain async calls.  

**Cons:**  
- Can lead to "callback hell" if deeply nested.  

**Example:**
```swift
func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
    URLSession.shared.dataTask(with: URL(string: "https://api.example.com")!) { data, _, error in
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            completion(.success(data))
        }
    }.resume()
}
```

---

## 3. Combine Framework
**How it works:**  
Uses **Publishers** and **Subscribers** for reactive, declarative handling of async streams.  

**Pros:**  
- Composable pipelines (`map`, `flatMap`, `decode`).  
- Handles cancellation, retries, and chaining elegantly.  

**Cons:**  
- Steeper learning curve.  
- iOS 13+ only.  

**Example:**
```swift
import Combine

class APIService {
    var cancellables = Set<AnyCancellable>()

    func fetchData() -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.example.com")!)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}

// Usage
let api = APIService()
api.fetchData()
    .sink(receiveCompletion: { print($0) },
          receiveValue: { data in print("Got data: \(data)") })
    .store(in: &api.cancellables)
```

---

## 4. Async/Await (Swift Concurrency)
**How it works:**  
Introduced in Swift 5.5 (iOS 15+). Allows writing async code in a synchronous style.  

**Pros:**  
- Clean, readable, no callback pyramids.  
- Structured concurrency with `Task`, `async let`, and `await`.  

**Cons:**  
- iOS 15+ only (unless back-deployed).  

**Example:**
```swift
func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

Task {
    do {
        let data = try await fetchData()
        print("Got data: \(data)")
    } catch {
        print("Error: \(error)")
    }
}
```

---

## 5. Notifications (NotificationCenter)
**How it works:**  
API manager posts notifications on events. Listeners observe those notifications.  

**Pros:**  
- Easy one-to-many communication.  

**Cons:**  
- Hard to track flow of data.  
- String-based, less type-safe.  

**Example:**
```swift
NotificationCenter.default.post(name: .dataFetched, object: data)

NotificationCenter.default.addObserver(forName: .dataFetched, object: nil, queue: .main) { notification in
    if let data = notification.object as? Data {
        print("Received: \(data)")
    }
}
```

---

## 6. Third-Party Reactive Frameworks (e.g., RxSwift)
- Similar to Combine but older and cross-platform. Provides advanced reactive operators.  
- Still common in projects that predate Combine.

---

## ✅ When to use what?
- **Delegates** → good for simple one-off communications (classic UIKit style).  
- **Closures** → simple APIs, when you don’t need streams.  
- **Combine** → complex pipelines, reactive architectures, iOS 13+.  
- **Async/Await** → modern, clean, preferred going forward (iOS 15+).  
- **Notifications** → broadcasting events.  
- **RxSwift** → legacy or cross-platform projects with heavy reactive needs.  
