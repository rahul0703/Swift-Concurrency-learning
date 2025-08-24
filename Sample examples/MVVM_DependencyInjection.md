
# MVVM + Dependency Injection in Swift (Minimal Example)

This is a **minimal MVVM + Dependency Injection (DI)** Swift example suitable for interviews.

---

## 🧠 Goal

Show:
- **MVVM**: Model–View–ViewModel separation
- **Dependency Injection**: Inject service into ViewModel

Scenario: Display a username fetched from a service.

---

## ✅ 1. Model

```swift
struct User {
    let name: String
}
```

---

## ✅ 2. Service Protocol & Implementation (for DI)

```swift
protocol UserService {
    func fetchUser() -> User
}

class DefaultUserService: UserService {
    func fetchUser() -> User {
        return User(name: "John Doe")
    }
}
```

---

## ✅ 3. ViewModel (uses DI + MVVM)

```swift
class UserViewModel {
    private let userService: UserService

    // DI happens here
    init(userService: UserService) {
        self.userService = userService
    }

    var userName: String {
        let user = userService.fetchUser()
        return user.name
    }
}
```

---

## ✅ 4. ViewController (View Layer)

```swift
import UIKit

class UserViewController: UIViewController {
    private let viewModel: UserViewModel

    // DI happens here too
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let label = UILabel()
        label.text = viewModel.userName
        label.center = view.center
        label.textAlignment = .center
        view.addSubview(label)
        label.frame = CGRect(x: 50, y: 200, width: 300, height: 40)
    }
}
```

---

## ✅ 5. App Launch / Assembly

```swift
// Manual Dependency Injection
let service = DefaultUserService()
let viewModel = UserViewModel(userService: service)
let viewController = UserViewController(viewModel: viewModel)

// now use `viewController` as root
```

---

## 🧩 Interview Talking Points

- **MVVM**: ViewModel exposes data (`userName`) to View. View has no business logic.
- **DI**: ViewModel doesn’t create its own dependencies — `UserService` is injected.
- **Testability**: In tests, you can inject a mock `UserService`.

---

## ✅ What to Practice

Write this whole setup from memory in 3–4 mins max. It's minimal but **checks all the MVVM + DI** boxes.
