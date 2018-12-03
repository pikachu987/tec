---
layout:     post
title:      swift IBDesignable, IBInspectable
date:       2018-12-03 08:00:00
summary:    Swift IBDesignable, IBInspectable 만들기
categories: swift
---

#### CustomView IBDesignable 만들기

```Swift

@IBDesignable
class CustomView: UIView {

}

```

#### CustomView에 IBInspectable 추가하기

```Swift

@IBDesignable
class CustomView: UIView {
    @IBInspectable
    var labelText: String? {
        set {
            self.label.text = newValue
        }
        get {
            return self.label.text
        }
    }

    @IBInspectable
    var labelTextColor: UIColor? {
        set {
            self.label.textColor = newValue
        }
        get {
            return self.label.textColor
        }
    }

    @IBInspectable
    var labelBackgroundColor: UIColor? {
        set {
            self.label.backgroundColor = newValue
        }
        get {
            return self.label.backgroundColor
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: label, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0),
            ])
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}


```

#### Storyboard나 xib에서 사용하기

![Alt Text](/tec/images/2018/12/designable/1.png)

![Alt Text](/tec/images/2018/12/designable/2.png)



#### 기타

Storyboard나 xib에서 사용할 경우

```Swift

override func awakeFromNib() {
    super.awakeFromNib()

}

```

이 호출된다.

코드상에서

```Swift

let customView = CustomView(frame: CGRect(x:0, y:0, width: 100, height: 100))

```

처럼 사용할 경우

```Swift

override init(frame: CGRect) {
    super.init(frame: frame)

}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

```

init이 호출되고
required init?(coder aDecoder: NSCoder) 을 같이 적어주어야 한다.
