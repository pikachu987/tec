---
layout:     post
title:      swift associatedType 연관타입
date:       2018-12-06 08:00:00
summary:    Swift protocol의 associatedType 써보기
categories: swift
---

이런 프로토콜이 있다고 가정해보자

```Swift

protocol ExampleProtocol {
    var value: Int { get }
}

```

코드에서 이 프로토콜을 공통적으로 사용을 하는데 value가 String이 필요한 화면이 있다.

그래서 하나더 만들면

```Swift

protocol ExampleProtocol2 {
    var value: String { get }
}

```

그러다가 value가 Int와 String을 받는 튜플이 필요하게 되었다.

```Swift

protocol ExampleProtocol3 {
    var value: (Int, String) { get }
}

```

이건 답이 아닌거같다...

그러면 value를 어디서든 사용할수 있게 타입을 AnyObject로 해보자

```Swift

protocol ExampleProtocol {
    var value: AnyObject { get }
}

class Example: ExampleProtocol {
    var value: AnyObject {
        return 10 as AnyObject
    }
}

class Example2: ExampleProtocol {
    var value: AnyObject {
        return "Hi" as AnyObject
    }
}

struct Example3: ExampleProtocol {
    var value: AnyObject {
        return (10, "Hi") as AnyObject
    }
}

```

이쁘지가 않다... 타입캐스팅을 해줘야한다.

이럴때 associatedType를 사용해보면

```Swift

protocol ExampleProtocol {
    associatedtype ExampleType

    var value: ExampleType { get }
}

class Example1: ExampleProtocol {
    typealias ExampleType = Int

    var value: ExampleType {
        return 10
    }
}

class Example2: ExampleProtocol {

    var value: String {
        return "Hi"
    }
}

struct Example3: ExampleProtocol {
    var item = (10, "HI")

    var value: (Int, String) {
        return self.item
    }
}

```

아주 만족스럽다.

사용하는 곳에서 타입을 변경해주는게 아주 편리하다.



```Swift

class Test {

}

protocol ExampleProtocol {
    associatedtype ExampleType: Test

    var value: ExampleType { get }
}

```

associatedtype에 타입을 지정해줄수 있다.

```Swift

class Test {

}

class Test1: Test {

}

class Test2: Test {

}

protocol ExampleProtocol {
    associatedtype ExampleType: Test

    var value: ExampleType { get }
}

class Example1: ExampleProtocol {

    var value: Test1 {
        return Test1()
    }
}

class Example2: ExampleProtocol {

    var value: Test2 {
        return Test2()
    }
}

```

이런식으로 짤수 있다.

associatedtype에 Equatable을 써보자

```Swift

protocol ExampleProtocol {
    associatedtype ExampleType: Equatable

    var value: ExampleType { get }
}

class Example1: ExampleProtocol {

    var value: Int {
        return 10
    }
}

class Example2: ExampleProtocol {

    var value: String {
        return "Hi"
    }
}

```

Equatable을 만족하는 타입을 사용하면 이런식으로 할수 있다.

Test에도 Equatable을 상속받아보자

```Swift

class Test: Equatable {
    var value = 0

    static func == (lhs: Test, rhs: Test) -> Bool {
        return lhs.value == rhs.value
    }
}

class Test1: Test {

}

class Test2: Test {

}

protocol ExampleProtocol {
    associatedtype ExampleType: Equatable

    var value: ExampleType { get }
}

class Example1: ExampleProtocol {

    var value: Test1 {
        return Test1()
    }
}

class Example2: ExampleProtocol {

    var value: Test2 {
        return Test2()
    }
}

```
