---
layout:     post
title:      swift AutoLayout의 활용
date:       2018-12-14 08:00:00
summary:    Swift AutoLayout의 Priority, Relation, 코드로 만들기, SnapKit
categories: swift
---

### Intrinsic Content Size

![Alt Text](/tec/images/2018/12/autolayout/ex1.png)

이렇게 슈퍼뷰의 길이보다 서브뷰의 길이가 작은 경우 Label의 길이를 글자에 대해 크기를 변경하려면

![Alt Text](/tec/images/2018/12/autolayout/ex2.png)

Label의 Content Hugging Priority에 Horizontal을 조절하면 된다.

![Alt Text](/tec/images/2018/12/autolayout/ex3.png)

이렇게 슈퍼뷰의 길이보다 서브뷰의 길이가 큰 경우 Label의 길이를 글자에 대해 크기를 변경하려면

![Alt Text](/tec/images/2018/12/autolayout/ex4.png)

Label의 Content Compression Resistance Priority를 조절하면 된다.

##### Hugging Priority

슈퍼뷰의 크기가 서브뷰의 크기보다 큰 경우 서브뷰의 우선순위를 줘서 우선순위에 따라 영역이 컨텐츠에 대해 최소로 잡히거나 남은 영역에 대해 최대로 잡히게 할수있다.

##### Compression Resistance Priority

슈퍼뷰의 크기가 서브뷰의 크기보다 작은 경우 서브뷰의 우선순위를 줘서 우선순위에 따라 서브뷰 끼리의 컨텐츠 영역을 짤라서 더 많이 보이게 할수있다.

##### Horizontal

수평의 뷰(좌,우) 에 적용이 된다.

##### Vertical

수직의 뷰(위,아래) 에 적용이 된다.

<br><br><br><br>

### AutoLayout

![Alt Text](/tec/images/2018/12/autolayout/ex5.png)

##### FirstItem

AutoLayout가 적용된 첫번째 컨텐츠이다.

##### SecondItem

AutoLayout가 적용된 두번째 컨텐츠이다.<br>
고정값으로 준 Width나 Height같이 컨텐츠의 연결이 필요없는 오토레이아웃은 SecondItem이 필요없다.

##### Relation

Greater Than or Equal (같거나 클수 있다), Less Than or Equal (같거나 작을수 있다), Equal(같다) 를 적용할수 있다.<br>
예를들어 superView에 view를 넣고 상하좌우에 constant를 0만 주었을때는 view가 superView의 크기를 따라가는데<br>
Relation을 주면 view의 컨텐츠의 길이가 superView의 크기보다 크지 않을때까지 view의 컨텐츠 크기를 따라가다가 superView의 크기보다 클때 superView의 크기를 따라가게 할수있다.

##### Constant

오토레이아웃의 값을 줄수있다.

##### Prioirty

오토레이아웃 끼리 우선순위를 줄수 있다.<br>
다양한 해상도에서 우선적으로 오토레이아웃이 적용을 할수 있기에 아주 유용하다.<br>
오트레이아웃의 충돌 에러를 처리할수 있다.

##### Multiplier

상대적인 비율로 레이아웃을 맞출 수 있다.<br>
다양한 해상도에서 superView와 비율로 width, height를 맞추기에 유용하다.

##### Identifier

오토레이아웃이 충돌이 났을때 명확하게 어떤 오토레이아웃이 에러가 난지 추적이 가능하다.<br>
코드로 identifier로 쉽게 오토레이아웃에 접근이 가능하다.

```swift
self.nameLabel.constraints.forEach({
    if $0.identifier == "nameLabelTopConstraint" {

    }
})
```

### 오토레이아웃 적용

오토레이아웃은 Storyboard나 Xib로 주는 방법이 있고 코드로 오토레이아웃을 주는 방법이 있다.<br>
코드로 오토레이아웃 주는 방법은 여러가지가 있는데

- NSLayoutConstraint
- Anchor
- Visual Format
- SnapKit (라이브러리)

가 있다.<br>
SnapKit는 라이브러리인데 아주좋다. 자주 사용이 된다.

##### NSLayoutConstraint

```swift
NSLayoutConstraint(
    item: Any,
    attribute: NSLayoutConstraint.Attribute,
    relatedBy: NSLayoutConstraint.Relation,
    toItem: Any?,
    attribute: NSLayoutConstraint.Attribute,
    multiplier: CGFloat,
    constant: CGFloat)
```

이렇게 생겼다.<br>
스토리보드와 비슷하게 firstItem은 첫번째 인자인 item에 넣고 secondItem은 toItem에 넣으면 된다.<br>
고정으로 주는 width나 height 같은 경우는 toItem에 nil값을 주면 된다.<br>
코드로 오토레이아웃을 줄때는 오토레이아웃을 주려는 뷰의 translatesAutoresizingMaskIntoConstraints을 false로 해야한다.<br>
relatedBy 는 Relation과 동일하고 attribute는<br>

- leading
- trailing
- top
- bottom
- centerX
- centerY
- width
- height
- left
- right

등의 옵션이 있다. <br>
item의 attribute와 toItem의 attribute에 대해 연결이 된다.<br>
예를들어 왼쪽 label과 오른쪽 label을 연결을 하려면<br>

'leading' - label1 - 'trailing' 'leading' - label2 - 'trailing'

으로 된다.

> leading vs left / trailing vs right
> leading는 항상 왼쪽이 아니다. 언어(Locale)에 따라 오른쪽이 될수 있다.

label1의 trailing과 label2의 leading이 연결이 된다.<br>
multiplier도 스토리보드에서 하던거와 비슷하고 constant도 동일하다.<br>
priority는

```swift
let constraint = NSLayoutConstraint(
    item: self.label1,
    attribute: .trailing,
    relatedBy: .equal,
    toItem: self.label2,
    attribute: .leading,
    multiplier: 1,
    constant: 0)
constraint.priority = UILayoutPriority()
```

이렇게 줄수 있다.

```swift
self.view.addConstraint(constraint)
```

이나

```swift
self.view.addConstraints([constraint])
```

이렇게 view에 오토레이아웃을 적용할수 있다.

##### Anchor


```swift
self.label1.leftAnchor.constraint(equalTo: self.label2.trailingAnchor, constant: 0).isActive = true
```

이렇게 NSLayoutConstraint보다 코드량이 줄었다.<br>
뷰에

- leftAnchor
- rightAnchor
- topAnchor
- bottomAnchor
- leadingAnchor
- trailingAnchor
- centerYAnchor
- centerXAnchor
- widthAnchor
- heightAnchor

등의 많은 프로퍼티가 있다.<br>
프로퍼티들은 NSLayoutXAxisAnchor, NSLayoutYAxisAnchor, NSLayoutDimension의 타입이고<br>
타입들은 여러 constraint의 함수를 equalTo, lessThanOrEqual, greaterThanOrEqualTo 등의 여러가지 인자가로 오버로드하고 있다.<br>
단점은 iOS 9.0 이상부터 지원이 된다. 만약 iOS 9.0이하를 지원하는 앱이라면 분기를 하거나 다른 방법을 사용해야 한다.

##### Visual Format

```swift
func constraints(
    withVisualFormat format: String,
    options opts: NSLayoutConstraint.FormatOptions = [],
    metrics: [String : Any]?,
    views: [String : Any]) -> [NSLayoutConstraint]
```

이렇게 생겼다.<br>
사용방법은

```swift
self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[webView]-0-|", options: [], metrics: nil, views: ["webView": self.webView])
)

self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolView]-0-|", options: [], metrics: nil, views: ["toolView": self.toolView])
)

self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "V:[toolView]-0-|", options: [], metrics: nil, views: ["toolView": self.toolView])
)

self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "V:|[topGuide]-0-[webView]-0-[toolView]|", options: [], metrics: nil, views: ["webView": self.webView, "toolView": self.toolView, "topGuide": self.topLayoutGuide])
)

self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "H:[webView]-(<=1)-[indicatorView]", options:.alignAllCenterY, metrics: nil, views: ["webView": self.webView, "indicatorView": self.indicatorView])
)

self.view.addConstraints(
    NSLayoutConstraint.constraints(withVisualFormat: "V:[webView]-(<=1)-[indicatorView]", options:.alignAllCenterX, metrics: nil, views: ["webView": self.webView, "indicatorView": self.indicatorView])
)
```

이렇게 사용할 수 있다.<br>
String으로 포맷을 지정해서 constraints를 만드는 것이다.<br>
장점은 "V:|[topGuide]-0-[webView]-0-[toolView]|" 이런식으로 여러개의 뷰들을 한번에 연결할수 있다.<br>
여러가지 포맷형태가 있다.

[developer.apple.com](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1)


##### SnapKit

[SnapKit](https://github.com/SnapKit/SnapKit)

아주 간단하게 되어있다.<br>
Objectvie-C에서는 [Masonry](https://github.com/SnapKit/Masonry) 를 쓴다.

```swift
imageView.snp.makeConstraints({ (make) in
    make.edges.equalToSuperview()
})

view.snp.makeConstraints({ (make) in
    make.center.equalToSuperview()
})

view.snp.makeConstraints({ (make) in
    make.centerX.equalTo(self.containerView.snp.centerX)
    make.bottom.equalTo(self.containerView.snp.top).inset(-10)
    make.width.equalTo(62)
    make.height.equalTo(8)
})

view.snp.makeConstraints({ (make) in
    make.centerX.equalTo(self.containerView.snp.centerX)
    make.bottom.equalTo(self.containerView.snp.top).inset(-10)
    make.width.equalTo(62)
    make.height.equalTo(8)
})
```

개인적으로 앱에 적용한 코드들을 그대로 붙여넣었는데 아주 간단하게 사용할수 있다.

### 뷰의 AutoLayout Animation

Storyboard에서 만든 오토레이아웃을 뷰컨트롤러 클래스 파일에 인터페이스 빌더 프로퍼티로 연결을 하면 이렇게 된다.

```swift
@IBOutlet weak var leftConstraint: NSLayoutConstraint!
```

leftConstraint값에 constant값을 변경을 하게 되면 그 값으로 바로 변경이 된다.<br>
여기서 애니메이션을 주려면

```swift
self.leftConstraint.constant = 100

UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
}
```

이렇게 하면 0.3초동안 애니메이션이 적용이 된다.<br>
뷰의 메서드 중에

- setNeedsLayout

해당 뷰와 하위 뷰를 다시 그려야한다는걸 알려준다.<br>
즉각적인 업데이트를 하지는 않지만 다음 업데이트 주기를 기다림. 모든 레이아웃 업데이트를 하나의 업데이트 주기로 통합 가능<br>
needLayout 플래그를 true로 바꿔줌<br>
postion이나 layout값을 변경하는 코드와 실제로 변경되는 시점에는 시간차가 있어서 업데이트 주기가 있다.

- leyoutIfNeeded

업데이트 주기를 기다리지 않고 즉시 업데이트한다.

- layoutSubviews

bounds 사이즈 변경되거나 가로세로 변화, layer변화나 setNeedsLayout, leyoutIfNeeded 호출될때 불려진다.

<br>

이상으로 오토레이아웃을 활용해보았다.
