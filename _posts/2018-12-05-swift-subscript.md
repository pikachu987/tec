---
layout:     post
title:      swift subscript
date:       2018-12-05 08:00:00
summary:    Swift subscript 써보기
categories: swift
---

#### Subscript


```swift
subscript(index: Int) -> Int {
    get {

    }
    set {

    }
}
```

또는

```swift
subscript(index: Int) -> Int {
    // get만 있는 subscript
}
```

이렇게 사용할수 있다.

Dictionary 타입에서는 key-value subscript로 구현되며 해당 key값의 옵셔널 타입을 받거나 리턴한다.<br>
Array 타입에서는 index를 받고 해당 index의 값을 받거나 리턴한다.

#### Example

```swift
struct TimesTable {
    let multiplier: Int

    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let timesTable = TimesTable(multiplier: 3)
print(timesTable[1])
print(timesTable[2])
print(timesTable[3])
```

```
3
6
9
```

```swift
struct Animal {
    let name: String

    subscript(index: Int) -> String {
        return name + "\(index)"
    }
}

let lion = Animal(name: "사자")
print(lion[0])
print(lion[1])
print(lion[2])

let dog = Animal(name: "개")
print(dog[0])
print(dog[1])
print(dog[2])
```

```
사자0
사자1
사자2
개0
개1
개2
```

index 인자값에는 Int뿐만 아니라 다른 타입들을 쓸수 있다.
리턴값도 동일하게 다른 타입들을 사용할 수 있다.
