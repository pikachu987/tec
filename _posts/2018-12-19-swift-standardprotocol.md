---
layout:     post
title:      swift 표준 라이브러리 프로토콜에 대해 알아보기
date:       2018-12-19 08:00:00
summary:    Swift equatable, comparable, sequence, iteratorProtocol, customStringConvertible
categories: swift
---

### equatable

equatable은 비교를 할수 있게 해주는 프로토콜이며<br>
기본적인 데이터 타입들도 적용이 되어있다.

```swift
extension String : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: String, rhs: String) -> Bool
}
```

우리가 struct나 class 를 만들었을때 비교를 하려면 `Binary operator '==' cannot be applied to two '' operands` 라는 컴파일 에러가 난다.<br>

```swift
struct NumberInt {
    let value: Int
}

class NumberDouble {
    let value: Double

    init(value: Double) {
        self.value = value
    }
}

if NumberInt(value: 2) == NumberInt(value: 5) {

}

if NumberDouble(value: 3) == NumberDouble(value: 2) {

}
```

struct에 equatable 프로토콜을 추가하면

```swift
struct NumberInt: Equatable {
    let value: Int
}

if NumberInt(value: 2) == NumberInt(value: 5) {

}
```

잘된다. 하지만 class에 equtable 프로토콜을 추가하면

```swift
class NumberDouble: Equatable {
    let value: Double

    init(value: Double) {
        self.value = value
    }
}

if NumberDouble(value: 3) == NumberDouble(value: 2) {

}
```

`Type 'NumberDouble' does not conform to protocol 'Equatable'` 이란 컴파일 에러가 난다.<br>
== 메서드를 적어줘야 한다.

```swift
class NumberDouble: Equatable {
    static func == (lhs: NumberDouble, rhs: NumberDouble) -> Bool {
        return lhs.value == rhs.value
    }

    let value: Double

    init(value: Double) {
        self.value = value
    }
}

if NumberDouble(value: 3) == NumberDouble(value: 2) {

}
```

이제 정상적으로 된다.

```swift
class NumberDouble: Equatable {
    let value: Double

    init(value: Double) {
        self.value = value
    }
}

func == (lhs: NumberDouble, rhs: NumberDouble) -> Bool {
    return lhs.value == rhs.value
}
```

이렇게 ==을 밖에서 구현해도 가능하다.<br>
struct는 ==가 기본적으로 구현이 되어있고 내가 다시 구현해줄수 있다.

```swift
struct NumberInt: Equatable {
    let value: Int

    static func == (lhs: NumberInt, rhs: NumberInt) -> Bool {
        return lhs.value == rhs.value
    }
}
```

### comparable

크고 작음을 비교하는 프로토콜이고 Equatable을 상속받아서 class에서는 Equatable에 있는 ==를 써주어야 한다.

```swift
struct NumberInt: Comparable {
    let value: Int

    static func < (lhs: NumberInt, rhs: NumberInt) -> Bool {
        return lhs.value < rhs.value
    }
}

class NumberDouble: Comparable {
    let value: Double

    init(value: Double) {
        self.value = value
    }

    static func == (lhs: NumberDouble, rhs: NumberDouble) -> Bool {
        return lhs.value == rhs.value
    }

    static func < (lhs: NumberDouble, rhs: NumberDouble) -> Bool {
        return lhs.value < rhs.value
    }
}

if NumberInt(value: 2) < NumberInt(value: 5) {

}

if NumberDouble(value: 3) > NumberDouble(value: 2) {

}
```

< 만 구현해주어도 >나 >=, <=를 사용할수 있다.<br>
<와 ==을 구현해주었으니까 나머지는 자동으로 계산이 된다.

### sequence, iteratorProtocol

sequence는 한번에 하나씩 수행할수 있는 값의 목록이다.<br>
sequence를 써주면 iteratorProtocol를 같이 써주어야 하는데

```swift
struct CountDown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

let countDown = CountDown(count: 5)
for i in countDown {
    print(i)
}
```

이렇게 사용가능하다.<br>
CountDown 는 자체 iterator로 사용되는 sequence 정의이다.<br>
아래 Sequence와 IteratorProtocol이 어떻게 만들어졌는지 보면 확실히 이해가 될것이다.

```swift
public protocol Sequence {

    /// A type representing the sequence's elements.
    associatedtype Element where Self.Element == Self.Iterator.Element, Self.Iterator.Element == Self.SubSequence.Element, Self.SubSequence.Element == Self.SubSequence.Iterator.Element

    /// A type that provides the sequence's iteration interface and
    /// encapsulates its iteration state.
    associatedtype Iterator : IteratorProtocol

    /// A type that represents a subsequence of some of the sequence's elements.
    associatedtype SubSequence : Sequence = AnySequence<Self.Element> where Self.SubSequence == Self.SubSequence.SubSequence

    /// Returns an iterator over the elements of this sequence.
    public func makeIterator() -> Self.Iterator
}

public protocol IteratorProtocol {

    /// The type of element traversed by the iterator.
    associatedtype Element

    /// Advances to the next element and returns it, or `nil` if no next element
    /// exists.
    ///
    /// Repeatedly calling this method returns, in order, all the elements of the
    /// underlying sequence. As soon as the sequence has run out of elements, all
    /// subsequent calls return `nil`.
    ///
    /// You must not call this method if any other copy of this iterator has been
    /// advanced with a call to its `next()` method.
    ///
    /// The following example shows how an iterator can be used explicitly to
    /// emulate a `for`-`in` loop. First, retrieve a sequence's iterator, and
    /// then call the iterator's `next()` method until it returns `nil`.
    ///
    ///     let numbers = [2, 3, 5, 7]
    ///     var numbersIterator = numbers.makeIterator()
    ///
    ///     while let num = numbersIterator.next() {
    ///         print(num)
    ///     }
    ///     // Prints "2"
    ///     // Prints "3"
    ///     // Prints "5"
    ///     // Prints "7"
    ///
    /// - Returns: The next element in the underlying sequence, if a next element
    ///   exists; otherwise, `nil`.
    public mutating func next() -> Self.Element?
}
```

### customStringConvertible

오브젝트를 문자열로 바꾸는 기능을 제공하는 프로토콜이다.

```swift
struct CustomStruct: CustomStringConvertible {
    let value: String
    var description: String {
        return "CustomStruct value: \(value)"
    }
}

class CustomClass: CustomStringConvertible {
    var value: String
    var description: String {
        return "CustomClass value: \(value)"
    }
    init(value: String) {
        self.value = value
    }
}

print(CustomStruct(value: "Hello").description)
print(CustomClass(value: "Hello").description)
```

class는 CustomStringConvertible을 추가하지 않아도 description를 사용할수 있다.<br>
하지만 CustomStringConvertible를 추가하면 description를 구현해주어야 한다.

이 외에도 많은 표준 라이브러리 프로토콜이 있다.<br>
[Apple](https://developer.apple.com/documentation/swift/swift_standard_library)
