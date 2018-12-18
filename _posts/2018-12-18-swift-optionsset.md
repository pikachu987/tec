---
layout:     post
title:      swift OptionSet 알아보기
date:       2018-12-18 08:00:00
summary:    Swift OptionSet 만들어보고 enum과의 차이 알아보기
categories: swift
---

### OptionSet

#### 사용

OptionSet은 enum과 비슷하지만 차이점이 둘 이상을 결합할수 있다.<br>
코드를 짤때 자주 OptionSet을 사용을 하는데 예를들어 UIBezierPath나 String의 range메서드에서 볼수 있다.

UIBezierPath의 생성자중 init(roundedRect: CGRect, byRoundingCorners: UIRectCorner, cornerRadii: CGSize) 생성자가 있는데 byRoundingCorners를 받는다.

```swift
UIBezierPath(roundedRect: .zero, byRoundingCorners: UIRectCorner.topLeft, cornerRadii: CGSize(width: 1.0, height: 1.0))
```

저렇게 topLeft, topRight, bottomLeft, bottomRight, allCorners중 하나를 받는데

```swift
UIBezierPath(roundedRect: .zero, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 1.0, height: 1.0))
```

이렇게 결합할수 있다.<br>
UIRectCorner를 확인해보면

```swift
public struct UIRectCorner : OptionSet {

    public init(rawValue: UInt)


    public static var topLeft: UIRectCorner { get }

    public static var topRight: UIRectCorner { get }

    public static var bottomLeft: UIRectCorner { get }

    public static var bottomRight: UIRectCorner { get }

    public static var allCorners: UIRectCorner { get }
}
```

이렇게 OptionSet으로 되어있다.<br>
String의 range메서드중 range(of:options:)에 options도 OptionSet으로 되어있다.

```Swift
public struct CompareOptions : OptionSet {

    public init(rawValue: UInt)


    public static var caseInsensitive: NSString.CompareOptions { get }

    public static var literal: NSString.CompareOptions { get }

    public static var backwards: NSString.CompareOptions { get }

    public static var anchored: NSString.CompareOptions { get }

    public static var numeric: NSString.CompareOptions { get }

    @available(iOS 2.0, *)
    public static var diacriticInsensitive: NSString.CompareOptions { get }

    @available(iOS 2.0, *)
    public static var widthInsensitive: NSString.CompareOptions { get }

    @available(iOS 2.0, *)
    public static var forcedOrdering: NSString.CompareOptions { get }

    @available(iOS 3.2, *)
    public static var regularExpression: NSString.CompareOptions { get }
}
```

그렇기 때문에

```swift
let example = "example"
let range = example.range(of: "am", options: [.caseInsensitive, .backwards])
```

과 같은 결합으로 여러 옵션을 쓸수 있다.

#### 만들기

OptionSet을 만드는거는 간단하게 struct에 OptionSet을 붙이면 된다.
Apple에 설명되어 있는 예제를 보면

```swift
struct ShippingOptions: OptionSet {
    let rawValue: Int

    static let nextDay    = ShippingOptions(rawValue: 1 << 0)
    static let secondDay  = ShippingOptions(rawValue: 1 << 1)
    static let priority   = ShippingOptions(rawValue: 1 << 2)
    static let standard   = ShippingOptions(rawValue: 1 << 3)

    static let express: ShippingOptions = [.nextDay, .secondDay]
    static let all: ShippingOptions = [.express, .priority, .standard]
}
```

이렇게 되어있다. 원시값은 1, 2, 4, 8, 16 등 2의 x제곱으로 하게 되어있다.<br>
[Apple](https://developer.apple.com/documentation/swift/optionset)

```swift
struct Direct: OptionSet {
    let rawValue: Int

    static let horizontal = Direct(rawValue: 1 << 0)
    static let vertical = Direct(rawValue: 1 << 1)
}
```

```swift
let horizontalDirect: Direct = Direct.horizontal
let verticalDirect: Direct = Direct.vertical
let allDirect: Direct = [Direct.horizontal, Direct.vertical]
```

이렇게 OptionSet을 사용할수 있다.
