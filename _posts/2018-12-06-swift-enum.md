---
layout:     post
title:      swift 열거형 enumeration
date:       2018-12-06 08:00:00
summary:    Swift enum 써보기 (associated value)
categories: swift
---

#### enum 기본


```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}
```

이런식으로 enum을 쓸수 있다.

```swift
enum CompassPoint {
    case north, south, east, west
}
```

case를 생략해서 사용할수도 있다.

```swift
let value = CompassPoint.north
```

이렇게 enum의 값을 가져올수 있다.

#### RawValue

```swift
enum CompassPoint: Int {
    case north, south, east, west
}

print(CompassPoint.north.rawValue)
print(CompassPoint.south.rawValue)
```

```
0
1
```

RawValue를 줄수 있다.
제일 앞의 값은 0부터 시작한다.

```swift
enum CompassPoint: Int {
    case north = 5
    case south, east, west
}

print(CompassPoint.north.rawValue)
print(CompassPoint.south.rawValue)
```

```
5
6
```

RawValue에 초기값을 줄수 있다.

```swift
enum CompassPoint: Int {
    case north = 5
    case south = 7
    case east = 9
    case west = 2
}

print(CompassPoint.north.rawValue)
print(CompassPoint.south.rawValue)
print(CompassPoint.east.rawValue)
print(CompassPoint.west.rawValue)
```

```
5
7
9
2
```

값을 각각 줄수 있다.

```swift
enum CompassPoint: String {
    case north = "동"
    case south = "서"
    case east = "남"
    case west = "북"
}

print(CompassPoint.north.rawValue)
print(CompassPoint.south.rawValue)
print(CompassPoint.east.rawValue)
print(CompassPoint.west.rawValue)
```

```
동
서
남
북
```

Int가 아닌 다른값으로 RawValue를 줄수 있다.

> RawValue값은 중복되면 안된다.

#### Associated Value (연관 값)

예를 들어 그림판에 그리기를 할수 있는 앱을 만들려고 한다.<br>
화면에 터치했을때 그리기, 지우개, 스포이드, 도형 타입이 있다.<br>
그러면

```swift
enum Draw {
    case pen
    case eraser
    case spoid
    case shape
}
```

이런식으로 나타낼수 있다.<br>
펜은 컬러, 사이즈<br>
지우개는 사이즈<br>
도형은 여러 도형타입들이 있다고 했을때 Associated Value를 사용할수 있다.

```swift
enum Draw {
    case pen(size: CGFloat, color: UIColor)
    case eraser(size: CGFloat)
    case spoid
    case shape(type: String)
}

let pen = Draw.pen(size: 5, color: .red)
```

이렇게 사용가능하다.<br>
도형도 enum으로 나타낼수 있다.

```swift
enum Shape {
    case line
    case square
    case circle
}

enum Draw {
    case pen(size: CGFloat, color: UIColor)
    case eraser(size: CGFloat)
    case spoid
    case shape(type: Shape)
}
```

```swift
let drawType = Draw.pen(size: 5, color: .red)
```

이렇게 pen을 만들었는데 pen의 size와 color를 가져오려면

```swift
switch drawType {
    case .pen(let size, let color):
        print("pen -> size: \(size), color: \(color)")
    case .eraser(let size):
        print("eraser -> size: \(size)")
    case .spoid:
        print("spoid")
    case .shape(let shape):
        print("shape -> \(shape)")
}
```

```
pen -> size: 5.0, color: UIExtendedSRGBColorSpace 1 0 0 1
```

switch로 가져올수 있다.

```swift
if case let .pen(size, color) = drawType {
    print("size: \(size), color: \(color)")
}
```

if case로도 가져올수 있다.


#### enum 비교

```swift
let line = Shape.line
let line2 = Shape.line

print(line == line2)
```

이렇게 단순한 enum은 비교가 가능하다.<br>
하지만 Associated Value가 들어간 enum은 기본적인 ==으로 비교할수 없다.

```swift
enum Draw {
    case pen(size: CGFloat, color: UIColor)
    case eraser(size: CGFloat)
    case spoid
    case shape(type: Shape)

    static func ==(lhs: Draw, rhs: Draw) -> Bool {
        switch (lhs, rhs) {
        case let (.pen(size1, color1), .pen(size2, color2)):
            return size1 == size2 && color1 == color2
        case let (.eraser(size1), .eraser(size2)):
            return size1 == size2
        case (.spoid, .spoid):
            return true
        case let (.shape(type1), .shape(type2)):
            return type1 == type2
        default:
            return false
        }
    }
}

let pen = Draw.pen(size: 11, color: .red)
let spoid = Draw.spoid

print(pen == spoid)
```

이렇게 ==를 직접 만들어서 비교할수 있다.

> lhs와 rhs는 Left-hand system, Right-hand system이란 뜻이다.

#### Property

```swift
enum Shape: String {
    case line = "라인"
    case square = "사각형"
    case circle = "원"
}

enum Draw {
    case pen(size: CGFloat, color: UIColor)
    case eraser(size: CGFloat)
    case spoid
    case shape(type: Shape)

    var title: String {
        switch self {
        case .pen:
            return "펜"
        case .eraser:
            return "지우개"
        case .spoid:
            return "스포이드"
        case .shape(let type):
            return type.rawValue
        }
    }
}
```

이렇게 enum에서 Property를 만들수 있고
method나 class도 만들수 있다.
