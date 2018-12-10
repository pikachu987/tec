---
layout:     post
title:      swift convenience 편의 생성자
date:       2018-12-10 08:00:00
summary:    Swift convenience
categories: swift
---

convenience는 편의 생성자라고 하는데

기존에 구현했던 init을 수정하지 않고 커스텀한 init을 사용할수 있게 할수 있다.
사용 방법은 init앞에 convenience을 붙인다.

그리고 convenience로 구현한 init은 동일한 클래스에서 다른 init을 호출하여야 한다.

그렇지 않으면 아래와 같은 에러가 나타나게 된다.

`'self.init' isn't called on all paths before returning from initializer`


```Swift

class SuperClass {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init(name: String) {
        self.name = name
        self.age = 15
    }

    convenience init(age: Int) {
        self.init(name: "Super", age: age)
    }
}

```




그리고 convenience을 구현한 클래스를 상속받은 클래스에서 convenience가 자동으로 상속이 되게 하는 방법이 있다.

#### 상속받은 클래스가 init을 하나도 구현하지 않았을때 자동으로 상위 클래스의 init이 상속된다.

```Swift

class SuperClass {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init(name: String) {
        self.name = name
        self.age = 15
    }

    convenience init(age: Int) {
        self.init(name: "Super", age: age)
    }
}

class FooClass: SuperClass {

}

let foo = FooClass(age: 20)

```

#### 상속받은 클래스가 상위 클래스의 모든 init을 구현했을때 자동으로 convenience을 상속한다.

```Swift

class SuperClass {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init(name: String) {
        self.name = name
        self.age = 15
    }

    convenience init(age: Int) {
        self.init(name: "Super", age: age)
    }
}

class BooClass: SuperClass {
    override init(name: String) {
        super.init(name: name)

    }

    override init(name: String, age: Int) {
        super.init(name: name, age: age)

    }
}

let boo = BooClass(age: 20)

```
