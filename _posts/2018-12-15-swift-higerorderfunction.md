---
layout:     post
title:      swift Higher Order Functions (고차함수), 고차함수 만들기
date:       2018-12-15 08:00:00
summary:    Swift Higher Order Functions 에 대해 알아보고 만들어보자
categories: swift
---

### Higher Order Functions 사용

array에 있는 값들을 출력을 할때

```swift
let array: [Int] = [1, 2, 3, 5, 7, 12, 24, 130]

for element in array {
    print(element)
}
```

이렇게 한다.<br>
index를 알고 싶으면

```swift
let array: [Int] = [1, 2, 3, 5, 7, 12, 24, 130]

for (index, element) in array.enumerated() {
    print("index: \(index), element: \(element)")
}
```

이렇게 한다.

##### forEach

이것을 그대로 고차함수로 적용해보면

```swift
array.forEach({ print($0) })

array.enumerated().forEach({ print("index: \($0.offset), element: \($0.element)") })
```

$0 대신 변수명을 적을수도 있다.

```swift
array.forEach({ element in
    print(element)
})

array.enumerated().forEach({ (index, element) in
    print("index: \(index), element: \(element)")
})
```

forEach는 for문과 비슷하게 element값을 반복할수 있다.

```swift
let dict: [String: AnyObject] = [
    "name": "Kim" as AnyObject,
    "age": 27 as AnyObject
]

dict.forEach({ print("key: \($0.key), value: \($0.value)") })
```

딕셔너리 형태도 사용가능하다.

```swift
let dict: [String: AnyObject] = [
    "name": "Kim" as AnyObject,
    "age": 27 as AnyObject
]
dict.keys.forEach({ print("key: \($0), value: \(dict[$0])") })
```

##### filter

```swift
let filterArray = array.filter ({ value -> Bool in
    return value < 10
})
```

필터를 줄수 있다. 더 간단하게 줄이면

```swift
let filterArray = array.filter({ $0 < 10 })
```

##### map

```swift
let mapArray = array.map({ "\($0)" })
```

이렇게 하면 타입이 [Int]였던게 [String]으로 리턴되어서 나온다.

##### compactMap

> flatMap은 Swift 4.1부터 deprecated되었다.
>
> `'flatMap' is deprecated: Please use compactMap(_:) for the case where closure returns an optional value`

```swift
let compactMapArray = array.compactMap({ "\($0)" })
```

map과 마찬가지 타입이 [Int]였던게 [String]으로 리턴되어서 나온다.<br>
map과 compactMap의 차이점은

```swift
let array = ["1", "hi", "2", "good"]

let mapArray = array.map({ Int($0) })
let compactMapArray = array.compactMap({ Int($0) })

print("mapArray: \(mapArray)")

print("compactMapArray: \(compactMapArray)")
```

```
mapArray: [Optional(1), nil, Optional(2), nil]
compactMapArray: [1, 2]
```

map은 옵셔널로 리턴을 했을때는 옵셔널의 형태로 반환이 된다.<br>
compactMap은 옵셔널로 리턴을 했을때 nil의 값이 제외되고 옵셔널이 벗겨져서 나오게 된다.<br>
두 함수 다 필요한 상황들이 있다.


##### sorted

```swift
array.sorted(by: { $0 > $1 })
```

고차함수로 소트를 할수 있다.

##### reduce

reduce는 초기값을 줄수 있고 어떻게 계산을 할지 정의할수 있다.

```swift
let value = array.reduce(1000000) { (result, value) -> Int in
    return result + value
}
```

더 간단하게 하면

```swift
let value2 = array.reduce(1000000, { $0 + $1 })
```

더 간단하게 하면

```swift
let value3 = array.reduce(1000000, +)
```

이렇게 까지 생략할수 있다.

##### Chaining

```swift
let array: [Int] = [1, 2, 3, 5, 7, 12, 24, 130]

let value = array.filter({ $0 < 10 })
            .sorted(by: { $0 > $1 })
            .map({ "\($0)" })
            .reduce("", { "\($0)\($1)" })
print(value)
```

```
75321
```

array중에 10 이하인것들만 가져오면 1, 2, 3, 5, 7<br>
sorted로 큰수로 오름차순으로 7, 5, 3, 2, 1<br>
map으로 String을 만들면 "7", "5", "3", "2", "1"<br>
reduce로 문자열을 합치면 75321이 된다.

### Higher Order Functions 만들기

map의 형태를 보면

```swift
public struct Array<Element> {
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
}
```

이렇게 되어 있다.<br>
이것을 보고 customMap을 만들어보면

```swift
extension Array {
    func customMap<T>(_ transform: (Element) -> T) -> [T] {
        var array = [T]()
        for element in self {
            array.append(transform(element))
        }
        return array
    }
}
```

이렇게 만들수 있다.

```swift
extension Array where Element == Int {
    func multiplication(_ value: Int) -> [Int] {
        var array = [Element]()
        for element in self {
            array.append(element * value)
        }
        return array
    }
}
```

간단하게 이렇게 곱셈을 할수 있는 함수를 만들어 볼수 있다.

> 예제가 잘 생각이 안난다.
