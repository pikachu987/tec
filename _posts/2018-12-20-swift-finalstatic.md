---
layout:     post
title:      swift final에 대해 알아보기
date:       2018-12-20 08:00:00
summary:    Swift class final, method final, final class func과 class func과 static
categories: swift
---

### class final

final키워드가 있는 class는 다른 class에서 상속받지 못한다.

```swift
final class Animal {
    var name = ""

}

class Dog: Animal {

}
```

`Inheritance from a final class 'Animal'` 이렇게 컴파일 에러가 난다.<br>
클래스를 다른 클래스에서 상속하면 안되는 경우에 사용할수 있다.

### method final

```swift
class Animal {
    final func bite() {

    }
}

class Dog: Animal {

    override func bite() {
        print("개가 뭅니다.")
    }
}
```

메서드에 final을 붙이고 override를 하면 `Instance method overrides a 'final' instance method`라는 컴파일 에러가 난다.<br>


### final class func과 class func과 static

```swift
class Animal {
    static func bite() {

    }
}

class Dog: Animal {
    override static func bite() {
        print("개가 뭅니다.")
    }
}

Animal.bite()
Dog.bite()
```

`Cannot override static method` 이렇게 static 메서드는 오버라이드 할수 없다는 컴파일에러가 나오는데

```swift
class Animal {
    class func bite() {

    }
}

class Dog: Animal {
    override class func bite() {
        print("개가 뭅니다.")
    }
}

Animal.bite()
Dog.bite()
```

이렇게 class로 바꿔주면 override가 가능하다.

```swift
class Animal {
    final class func bite() {

    }
}

class Dog: Animal {
    override final class func bite() {
        print("개가 뭅니다.")
    }
}

Animal.bite()
Dog.bite()
```

여기에 final을 붙이게 되면 override를 할수 없어진다.<br>
static과 final class는 같은 기능을 할수있다.
