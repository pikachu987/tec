---
layout:     post
title:      swift AccessControl 알아보기
date:       2018-12-17 08:00:00
summary:    Swift open, public, internal, fileprivate, private
categories: swift
---

## Access Control 접근 한정자

class나 struct, enum, extension, method에 접근 한정자를 붙여 모듈 외부에서 사용할수 있거나 클래스 내부에서만 사용하게 할수 있다.<br>
접근한정자의 종류는 open, public, internal, fileprivate, private 이 있다.

### open

가장 열려있는 접근 한정자이고 전체적으로는 public과 유사하지만

- 타모듈에서 만들어진 class의 접근한정자가 open 이면 상속을 할수 있다.
- 타모듈에서 만들어진 method의 접근한정자가 open이면 override를 할수 있다.
- 같은 모듈에서는 public이나 internal과 동일하다.

### public

- 다른 모듈의 public 로 된 클래스를 상속할려고 하면
`Cannot inherit from non-open class '' outside of its defining module` 이란 class가 open 되지 않았다는 에러가 나온다.
- 다른 모듈의 public로 된 메서드를 override 하려고 하면
`Overriding non-open instance method outside of its defining module` 이란 method가 open되지 않았다는 에러가 나온다.

### internal

타 모듈에서 internal 접근한정자로 만들어진 클래스를 코드에서는 가져올수 없지만 storyboard, xib에서는 가져올수 있다.

> xml에서도 internal의 접근한정자는 쓸수 없어야 하는데 xml과 코드에서 타모듈을 가져오는 구조가 달라서 가져올수 있는거 같다.
> xml에서 @IBOutlet(Interface Bulider Outlet)로 연결하면 `Use of undeclared type ''` 이런 에러가 나온다.

접근한정자를 지정하지 않았을때 기본적으로 사용되는 접근 수준이고 같은 모듈에서는 자유롭게 사용가능하다.

### fileprivate

타 모듈에서 만들어진 클래스나 메서드를 코드나 storyboard, xib에서 가져올수 없다.<br>
같은 모듈에서 만들어진 fileprivate 접근한정자 클래스를 storyboard, xib에서  `Unknown class 클래스명 in Interface Builder file.` 이란 에러가 나온다.<br>
클래스는 같은 파일내에서만 접근가능하고 메서드도 같은 파일 내에서만 접근가능하다.

### private

타 모듈에서 만들어진 클래스나 메서드를 코드나 storyboard, xib에서 가져올수 없다.<br>
같은 모듈에서 만들어진 클래스를 xml에서 `Unknown class 클래스명 in Interface Builder file.` 이란 에러가 나온다.<br>
클래스는 같은 파일내에서만 접근가능하고 메서드는 같은 블록(클래스) 내에서만 접근가능하다.

```swift
class ViewController: UIViewController {
    private var name = ""
}

extension ViewController {
    func doSomething() {
        self.name = "name"
    }
}
```

같은 파일에서는 이렇게 extension 안에서도 class, struct, enum등 같은 영역에서는 접근 가능하다.

### 정리

##### 같은 모듈

###### 클래스

- 상속가능: open, public, internal
- 접근가능: open, public, internal
- storyboard, xml에서 사용가능: open, public, internal
- 같은파일에서 접근 가능: open, public, internal, fileprivate, private

###### 메서드

- 오버라이드가능: open, public, internal
- 호출가능: open, public, internal
- 같은파일에서 호출 가능: open, public, internal, fileprivate

##### 타 모듈

###### 클래스

- 상속가능: open
- 접근가능: open, public
- xml에서 사용가능: open, public, internal

###### 메서드

- 오버라이드가능: open
- 호출가능: open, public


> open, public, internal은 타모듈을 사용할때 차이가 나누어진다.
> fileprivate와 private은 메서드를 호출할때 블럭 내부에서 호출인지 블럭 외부에서 호출인지 차이가 나누어진다.

#### set

```swift
internal(set) var name = "Kim Gwanho"
fileprivate(set) var age = 27
private(set) var gender = "M"
```

이렇게 접근한정자 뒤에 set을 붙여도 된다.<br>
set을 붙인다는 것은 name이나 age, gender를 접근할때는 internal수준으로 어디서든지 접근할수 있지만 set할때는 접근한정자를 따른다.

- name같은 경우는 어디서든지 값을 출력하고 어디서든지 값을 바꿀수 있다.
- age같은 경우는 어디서든지 값을 출력하지만 같은 파일내에서만 값을 바꿀수 있다.
- gender같은 경우는 어디서든지 값을 출력하지만 같은 클래스(블럭) 내부에서만 값을 바꿀수 있다.

#### inheritModuleFromTarget

![Alt Text](/tec/images/2018/12/accessControl/inheritModuleFromTarget.png)

> By checking the "Inherited from Target" option the module gets compiled in for the targets I use it in (Target Memberships for swift file and everything works.

Inherit Module From Target을 체크하면 내가 소속되어있는 타겟 모듈만 기본적으로 선택되고 체크를 안하면 모듈을 직접 넣어줘야 한다.
