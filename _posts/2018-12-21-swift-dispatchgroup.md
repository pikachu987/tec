---
layout:     post
title:      swift DispatchGroup 알아보기
date:       2018-12-21 08:00:00
summary:    Swift DispatchGroup의 메서드에 대해 알아보기
categories: swift
---

### DispatchGroup

어떤 작업의 동기화를 그룹으로 묶을수 있다.<br>
여러 작업들이 각각의 큐에서 동작하고 모든 작업이 완료되었을때를 알수 있다.

```swift
let workGroup = DispatchGroup()

workGroup.enter()
print("work1 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
    print("work1 end")
    workGroup.leave()
}

workGroup.enter()
print("work2 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    print("work2 end")
    workGroup.leave()
}

workGroup.notify(queue: DispatchQueue.main) {
    print("Complete")
}
```

```
work1 start
work2 start
work1 end
work2 end
Complete
```

DispatchWorkItem으로도 쓸수 있다.

```swift
let workGroup = DispatchGroup()

workGroup.enter()
print("work1 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
    print("work1 end")
    workGroup.leave()
}

workGroup.enter()
print("work2 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    print("work2 end")
    workGroup.leave()
}

let workItem = DispatchWorkItem(block: {
    print("workItem")
})

workGroup.notify(queue: DispatchQueue.main, work: workItem)
```

```
work1 start
work2 start
work1 end
work2 end
workItem
```

또는 다음 작업을 멈추게 할수 있다.

```swift
let workGroup = DispatchGroup()

workGroup.enter()
print("work1 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
    print("work1 end")
    workGroup.leave()
}

workGroup.enter()
print("work2 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    print("work2 end")
    workGroup.leave()
}

workGroup.wait()
print("Complete")
```

```
work1 start
work2 start
work1 end
work2 end
Complete
```

waite에 타임아웃을 줄수도 있다.

```swift
let workGroup = DispatchGroup()

workGroup.enter()
print("work1 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
    print("work1 end")
    workGroup.leave()
}

workGroup.enter()
print("work2 start")
DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    print("work2 end")
    workGroup.leave()
}

workGroup.notify(queue: .main) {
    print("Complete notify")
}
_ = workGroup.wait(timeout: DispatchTime.now() + 0.8)
print("Complete")
```

```
work1 start
work2 start
work1 end
Complete
work2 end
Complete notify
```

##### enter

작업이 시작된다는 메서드이다.

##### leave

enter과 쌍을 이루며 작업이 끝난다는 메서드이다.

##### wait

다음 라인으로 넘어가지 않고 대기하고 있게 해주는 메서드이다.

##### notify

작업이 완료되면 호출되는 클로져이다.
