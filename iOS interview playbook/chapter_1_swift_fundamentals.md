# Chapter 1: Swift Language Fundamentals (L4-Level iOS Interview Guide)

---

## 📘 Overview
This chapter covers foundational Swift language concepts required to demonstrate technical depth in interviews at companies like Google and Meta. Mastery of these fundamentals enables clean code, high performance, and safe memory management across real-world app modules.

---

## 📌 1. Value vs Reference Types

### 💡 Core Concepts
- **Value Types:** Structs, enums — copied on assignment
- **Reference Types:** Classes — passed by reference
- ARC only applies to reference types.

### 📍 When to Use
| Use Struct When | Use Class When |
|----------------|----------------|
| Data is immutable | Shared mutable state needed |
| Copying is cheap | Inheritance or polymorphism is needed |
| No reference identity needed | Requires lifecycle/memory control |

### ⚠️ Common Pitfalls
- Capturing a `self` reference inside a closure from a class leads to retain cycles if not marked `[weak self]` or `[unowned self]`
- Value types (structs) are copied — modifying one copy doesn’t affect the original.

### ✅ Interview Example
**Q:** What's the difference between a struct and a class in Swift?

**A:** Structs are value types — they're copied when passed around. Classes are reference types — passed by reference, and managed with ARC. Structs are preferred when you don't need identity or shared mutation.

---

## 📌 2. Enums and Associated Values

### 💡 Core Concepts
- Swift enums can have **associated values**, unlike C-style enums
- Can be recursive (via `indirect`) and expressive with `switch`

```swift
enum Result<T> {
    case success(T)
    case failure(Error)
}
```

### ✅ Interview Example
**Q:** How do Swift enums differ from Objective-C or Java enums?

**A:** Swift enums can store data (associated values) and support pattern matching. This makes them more powerful — closer to algebraic data types in functional programming.

---

## 📌 3. Protocols and Protocol-Oriented Programming

### 💡 Core Concepts
- Protocols define *behavior*, not data
- Support default implementations via protocol extensions
- Enable testability, mocking, and clean architecture

```swift
protocol APIClient {
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T
}
```

### 🔄 Protocol vs Class
| Protocol               | Class                   |
|------------------------|--------------------------|
| Behavior abstraction   | Full implementation     |
| Multiple conformances  | Single inheritance       |
| Used for DI & mocking  | Used for instancing/ARC |

### ⚠️ Pitfall
- Protocols with associated types (`PATs`) can’t be used directly as concrete types.

### ✅ Interview Example
**Q:** Why might you use a protocol over a class?

**A:** Protocols promote composition over inheritance, improve testability, and allow flexible mocking and dependency injection — especially useful in MVVM or VIPER.

---

## 📌 4. Generics

### 💡 Core Concepts
- Reusable logic while preserving type safety
- Used in `Array`, `Dictionary`, and custom data structures

```swift
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```

### ✅ Interview Example
**Q:** What are the benefits of generics in Swift?

**A:** Generics let you write reusable, type-safe code. They prevent duplication and runtime casting errors, and they’re essential for building flexible APIs.

---

## 📌 5. Property Wrappers

### 💡 Core Concepts
- Add reusable behavior to property declarations

```swift
@propertyWrapper
struct Clamped {
    var value: Int
    var wrappedValue: Int {
        get { value }
        set { value = min(max(newValue, 0), 100) }
    }
}
```

### ✅ SwiftUI Built-in Examples
- `@State`, `@ObservedObject`, `@Published`, `@AppStorage`

### ✅ Interview Example
**Q:** What problem do property wrappers solve?

**A:** They separate behavior (e.g., clamping, persistence) from property declarations, improving code modularity and reusability.

---

## 📌 6. Swift Memory Model (Closures & Captures)

### 💡 Core Concepts
- Closures capture values — by default, class references are strong
- Use `[weak self]` or `[unowned self]` to break cycles
- Escaping closures (`@escaping`) are stored after function returns

```swift
api.load { [weak self] result in
    self?.handle(result)
}
```

### ✅ Interview Example
**Q:** Why does a closure inside a class create a retain cycle?

**A:** If the closure captures `self` strongly and the class instance also retains the closure (e.g. as a callback), they retain each other — preventing deallocation. Use `[weak self]` to avoid this.

---

## ✅ Summary Checklist
- [ ] Understand ARC and copy-on-write clearly
- [ ] Know how protocols enable testing and composition
- [ ] Be fluent in writing & reasoning about generics
- [ ] Avoid retain cycles in closures with proper capture lists
- [ ] Leverage Swift enums for expressive, safe modeling

---

Let me know when you're ready to build Chapter 2: Memory Management and ARC.

