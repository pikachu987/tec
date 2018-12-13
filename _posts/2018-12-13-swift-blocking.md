---
layout:     post
title:      swift blocking, non-blocking
date:       2018-12-13 08:00:00
summary:    Swift sync, async, blocking, non-blocking에 대해 알아보자
categories: swift
---

#### blocking

```swift
class Network {
    var isLoading = false

    func blocking() -> Bool {
        print("start date: \(Date().timeIntervalSince1970)")
        sleep(1)
        print("end date: \(Date().timeIntervalSince1970)")
        return true
    }
}

class Example {

    init() {
        let network = Network()

        let result = network.blocking()
        print("complete \(result) date: \(Date().timeIntervalSince1970)")
    }
}
```

```swift
start date: 1544249905.254097
end date: 1544249906.254911
complete true date: 1544249906.25496
```

블러킹은 함수를 호출했을때 결과가 나올때까지 함수를 반환하지 않는다.

#### non-blocking

```swift
class Network {
    var isLoading = false

    func nonBlocking() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.isLoading = true
            print("start date: \(Date().timeIntervalSince1970)")
            sleep(1)
            self.isLoading = false
            print("end date: \(Date().timeIntervalSince1970)")
        }
    }
}

class Example {

    init() {
        let network = Network()

        network.nonBlocking()
        print("complete \(network.isLoading) date: \(Date().timeIntervalSince1970)")
    }
}
```

```swift
complete false date: 1544250075.108323
start date: 1544250075.214427
end date: 1544250076.21679
```

넌블러킹은 함수를 호출했을때 바로 반환하고 다른 작업을 수행할 수 있다.


#### Sync(동기)

```swift
class Network {
    var isLoading = false

    func sync() -> Bool {

        return true
    }
}

class Example {

    init() {
        let network = Network()

        let value = network.sync()
    }
}
```

함수의 작업완료를 기다린다.

#### Async(비동기)

```swift
class Network {
    var isLoading = false

    func async(_ callback: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            callback()
        }
    }
}

class Example {

    init() {
        let network = Network()
        network.async {
            print("complete")
        }
    }
}
```

함수의 작업완료를 기다리지 않고 callback으로 받는다.


## Sync/Async와 Blocking/NonBlocking를 같이 사용

### Sync-Blocking

```swift
class Network {
    var isLoading = false

    func syncBlocking() -> Bool {
        sleep(1)
        return true
    }
}

class Example {

    init() {
        let network = Network()
        let value = network.syncBlocking()
    }
}
```

싱크 블러킹은 함수를 호출후 리턴될때 까지 아무작업을 할수 없다.<br>
함수의 작업내용이 작거나 시간이 아주 작게 걸릴때 사용된다.<br>
그렇지 않으면 앱이 프리즈상태가 될 가능성이 많다.

### Sync-NonBlocking

```swift
class Network {
    var isLoading = false

    func syncNonBlocking() -> Bool {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            print("work")
        }
        return true
    }
}

class Example {

    init() {
        let network = Network()
        let value = network.syncNonBlocking()
    }
}
```

싱크 논블러킹은 함수를 호출후 바로 리턴받고 다른작업을 할수 있다. <br>
해당 함수의 작업 결과가 중요하지 않을 경우 사용한다.


### Async-Blocking

```swift
class Network {
    var isLoading = false

    func asyncBlocking(_ callback: () -> Void) {
        sleep(1)
        callback()
    }
}

class Example {

    init() {
        let network = Network()
        network.asyncBlocking {

        }
    }
}
```

어싱크 블로킹은 콜백호출까지 다른 작업을 할수 없다. <br>
거의 사용되지 않는다.

### Async-NonBlocking

```swift
class Network {
    var isLoading = false

    func asyncNonBlocking(_ callback: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            callback()
        }
    }
}

class Example {

    init() {
        let network = Network()
        network.asyncNonBlocking {
            print("complete")
        }
        print("other work")
    }
}
```

어싱크 논블러킹은 콜백호출전에 다른작업이 가능하다. <br>
함수에서 작업이 완료되면 콜백이 호출된다.<br>
가장 많이 쓰이는 형태이다.
