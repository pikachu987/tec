---
layout:     post
title:      swift semaphore
date:       2018-12-12 08:00:00
summary:    Swift semaphore 알아보기
categories: swift
---

세마포어를 사용하기전에 세마포어가 왜 생겼는지 알아보자<br>
하나의 자원에 접근할때 동시에 여러 쓰레드에서 그 하나의 자원에 접근한다면?

```swift
var array = [Int]()

DispatchQueue.global().async {
    for element in 0...1000 {
        array.append(element)
    }
}

DispatchQueue.global().async {
    for element in 0...1000 {
        array.append(element)
    }
}
```

```
malloc: *** error for object 0x10b4d6cb0: pointer being freed was not allocated
malloc: *** set a breakpoint in malloc_error_break to debug
```

이렇게 에러가 난다.<br>
이렇게 하나의 자원에 여러 곳에서 접근을 하는 것을 레이스 컨디션(Race Condition)이라고 한다.

> 레이스 컨디션: 한정된 자원을 동시에 이용하려는 여러 프로세스가 자원의 이용을 위해 경쟁을 벌이는 현상

<<<<<<< HEAD
동시 접근문제를 발생시킬수 있는 코드 블록을 임계영역이라고 한다.<br>
동시 접근문제를 해결하기 위한 동기화 기법이 크리티컬 섹션(Critical Section) 이라고 하고,<br>
크리티컬 섹션 기법이 세마포어, 뮤텍스 등이 있다.
=======
동기화 방법은 크리티컬 섹션(Critical Section)이라고 한다. 임계영역이라고도 한다.

동시 접근문제를 해결하기 위한 동기화 기법이 세마포어, 뮤텍스 등이 있다.
>>>>>>> 8cff8e6614de1bc3727bab367daf1723057b1d88

- 뮤택스는 한정된 자원에 하나만 접근 가능하고
- 세마포어는 한정된 자원에 하나 이상이 접근할 수 있다.

Swift 에서는 세마포어를 사용하기 위한 `DispatchSemaphore` 클래스가 있다.<br>
`DispatchSemaphore`를 생성할때 자원에 접근할 수 있는 갯수를 준다.

```swift
let semaphore = DispatchSemaphore(value: 10)
```

이렇게 하면 10개가 자원에 접근할수 있다.

```swift
DispatchSemaphore(value: 1)
```

로 하면 하나만 자원에 접근할수 있고 뮤택스처럼 사용할수 있다.<br>
`DispatchSemaphore`의 메서드에는

- wait: value값이 -1 작아진다.
- signal: value 값이 +1 더해진다.

> value값의 0이면 자원에 접근할수 없다.

```swift
var array = [Int]()
let semaphore = DispatchSemaphore(value: 1)

DispatchQueue.global().async {
    for element in 0...1000 {
        semaphore.wait()
        array.append(element)
        semaphore.signal()
    }
}

DispatchQueue.global().async {
    for element in 0...1000 {
        semaphore.wait()
        array.append(element)
        semaphore.signal()
    }
}
```

이런식으로 하게 되면 자원을 한번씩만 접근을 해서 레이스 컨디션의 문제가 일어나지 않는다.
