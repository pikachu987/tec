---
layout:     post
title:      swift Declaration Attributes 알아보기
date:       2018-12-22 08:00:00
summary:    Swift @objc, @escaping, @autoclosure, @discardableResult
categories: swift
---

### @objc

Swift에서 objc라는 키워드는 심볼을 Objective-C 네임스페이스에 알려주는 역활이다.<br>
Swift는 Objective-C 에서 찾을수 없게 되어있는데 찾을수 있게 해주는 것이 objc이다.

##### selector

```swift
self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTap(_:)))

private func doneTap(_ sender: UIBarButtonItem) {

}
```

이렇게 적으면 `Argument of '#selector' refers to instance method 'doneTap' that is not exposed to Objective-C` 라고 에러가 난다.<br>
@objc를 추가해주면 된다.

```swift
@objc private func doneTap(_ sender: UIBarButtonItem) {

}
```

Swift에서 #selector는 Objective-C 메소드여야 하기 때문에 @objc를 붙여줘야 한다.

##### class method

```swift
@objc(PKCMYViewContoller)
class MyViewController: UIViewController {

    @objc(pkcFetchData)
    func fetchData() {

    }
}
```

Swift는 모듈내에 존재하는 class나 extension에 동일한 메서드명을 가진게 존재할 경우 바로 컴파일 에러가 발생해서 prefix를 안붙여도 된다.<br>
Objective-C에서는 컴파일 에러가 아니라 그냥 빌드되고 같은 이름의 아무 클래스나 메서드가 불려진다.<br>
그래서 @objc로 Objective-C에서 사용할 클래스명, 메서드명을 바꿔준다.

### escaping

[swift @escaping @noescape](https://pikachu987.github.io/tec/swift/2018/12/07/swift-escape/) 참조


### autoclosure

```swift
func someFunction(_ closure: () -> Void) {
    print("someFunction1")
    closure()
}
someFunction { print("Hello1") }
someFunction({ print("Hello2") })
```

클로져를 보통 저런식으로 사용할것이다.<br>
하지만 라이브러리들을 보면

```swift
someFunction(print("Hello1"))
```

이렇게 사용하는 모습을 볼수 있다.<br>
`someFunction`에 저렇게 사용하면 `Cannot convert value of type '()' to expected argument type '() -> Void'`라는 에러가 나온다.

```swift
func someFunction2(_ closure: @autoclosure () -> Void) {
    print("someFunction2")
    closure()
}

someFunction2(print("Hello3"))
```

@autoclosure를 사용하여 `someFunction2(print("Hello3"))`가 되게 할수 있다.<br>
비동기 실행이나 클로져를 저장해서 사용할 경우 @escaping를 추가해줄수도 있다.

```swift
func someFunction2(_ closure: @escaping @autoclosure () -> Void) {
    print("someFunction2")
    DispatchQueue.main.async {
        closure()
    }
}

someFunction2(print("Hello3"))
```

### discardableResult

```swift
let textField = UITextField()
let isComplete = textField.resignFirstResponder()
textField.resignFirstResponder()
```

텍스트필드에 resignFirstResponder라는 메서드가 있다.<br>
이 메서드는 리턴값이 있는데 리턴값을 변수로 저장하거나 사용하지 않아도 `Result of call to '' is unused` 이런 경고창이 뜨지 않는다.

```swift
@discardableResult
func example() -> Bool {
    return true
}
```

이렇게 @discardableResult를 써주면 값을 사용하지 않아도 경고창이 뜨지 않는다.<br>
값이 필요할수도 있고 값이 필요없을수도 있는 메서드에 사용하면 경고창이 뜨지 않아서 좋다.

<br><br><br>

[THE SWIFT PROGRAMMING LANGUAGE](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 를 보면 엄청 많은 Declaration Attributes가 있다.
