---
layout:     post
title:      swift where의 사용
date:       2018-12-16 08:00:00
summary:    Swift 여러군데에서 나오는 where을 사용해보자
categories: swift
---

코드를 짜다보면 어려군데에서 where을 사용하고 있다.<br>
where를 사용하는 곳을 정리해보자

### for

```swift
let array: [Int] = [1, 2, 3, 5, 7, 12, 24, 130]

for element in array where element%2 == 0 {
    print(element)
}
```

for문에 where을 추가해서 원하는 값만 동작하게 할수 있다.

### switch case

```swift
enum NetworkType {
    case success
    case suspend
    case error(code: Int)

    var result: Bool {
        switch self {
        case .success:
            return true
        case .suspend:
            return false
        case .error(let statusCode) where 200 < statusCode && statusCode < 300:
            return true
        default:
            return false
        }
    }
}
```

case에 where를 넣어서 해당하는 것만 빼낼수 있다.

### extension

```swift
extension Array where Element == Int {
    func sum() -> Int {
        return self.reduce(0, +)
    }
}

[1, 3, 5, 6].sum()
```

extension에 원하는 타입만 받을수 있다.

### func

```swift
func printValue<T>(_ value: Optional<T>) where T: Equatable {
    print(value)
}

self.printValue(50)

self.printValue("홍길동")
```

```swift
class People: Equatable {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    static func == (lhs: People, rhs: People) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}

self.printValue(People(name: "홍길동", age: 50))
```

func에 원하는 타입만 받을수 있다.
