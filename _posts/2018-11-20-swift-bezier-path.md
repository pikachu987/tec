---
layout:     post
title:      swift UIBezierPath Shape
date:       2018-11-20 08:00:00
summary:    Swift UIBezierPath로 여러가지 도형, 말풍선 그리기(Arrow, Triangle, Square, Pentagon, Star, Heart, Bubble, Chat, Message)
categories: swift
---

#### 1. 라인(Line)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: rect.height / 2))
        linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        linePath.lineWidth = 6
        UIColor.black.set()
        linePath.stroke()
        linePath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/line.png)

<br><br>

#### 2. 화살표(Arrow)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
      let path = UIBezierPath(rect: rect)
      UIColor.lightGray.setFill()
      path.fill()
      path.close()

      let arrowPath = UIBezierPath()
      let margin = rect.width/2
      arrowPath.move(to: CGPoint(x: 0, y: rect.height/2))
      arrowPath.addLine(to: CGPoint(x: margin, y: rect.height/2 - margin))
      arrowPath.addLine(to: CGPoint(x: margin, y: rect.height/2 - margin/3))
      arrowPath.addLine(to: CGPoint(x: rect.width, y: rect.height/2 - margin/3))
      arrowPath.addLine(to: CGPoint(x: rect.width, y: rect.height/2 + margin/3))
      arrowPath.addLine(to: CGPoint(x: margin, y: rect.height/2 + margin/3))
      arrowPath.addLine(to: CGPoint(x: margin, y: rect.height/2 + margin))
      arrowPath.addLine(to: CGPoint(x: 0, y: rect.height/2))

      UIColor.black.set()
      arrowPath.stroke()
      arrowPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/arrow.png)

<br><br>

#### 3. 삼각형(Triangle)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let triangle = UIBezierPath()
        let y = rect.height - sqrt(pow(rect.width, 2) - pow(rect.width/2, 2))
        triangle.move(to: CGPoint(x: 0, y: rect.height - y/2))
        triangle.addLine(to: CGPoint(x: rect.width, y: rect.height - y/2))
        triangle.addLine(to: CGPoint(x: rect.width/2, y: y - y/2))
        triangle.addLine(to: CGPoint(x: 0, y: rect.height - y/2))

        UIColor.black.set()
        triangle.stroke()
        triangle.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/triangle.png)

<br><br>

#### 4. 사각형(Square)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let squarePath = UIBezierPath()
        let squareRect = CGRect(x: 10, y: 10, width: rect.width-10, height: rect.height-10)
        squarePath.move(to: CGPoint(x: squareRect.origin.x, y: squareRect.origin.y))
        squarePath.addLine(to: CGPoint(x: squareRect.width, y: squareRect.origin.y))
        squarePath.addLine(to: CGPoint(x: squareRect.width, y: squareRect.height))
        squarePath.addLine(to: CGPoint(x: squareRect.origin.x, y: squareRect.height))
        squarePath.addLine(to: CGPoint(x: squareRect.origin.x, y: squareRect.origin.y))

        UIColor.black.set()
        squarePath.stroke()
        squarePath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/square.png)

<br><br>

#### 5. 오각형(Pentagon)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let pentagonPath = UIBezierPath()

        let width = rect.width
        let height = rect.height
        let center = CGPoint(x: width/2, y: height/2)

        let sides = 5
        let cornerRadius: CGFloat = 1
        let rotationOffset = CGFloat(Double.pi / 2.0)
        let theta: CGFloat = CGFloat(2.0 * Double.pi) / CGFloat(sides)
        let radius = (width + cornerRadius - (cos(theta) * cornerRadius)) / 2.0

        var angle = CGFloat(rotationOffset)

        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        pentagonPath.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
        for _ in 0 ..< sides {
            angle += theta
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
            pentagonPath.addLine(to: start)
            pentagonPath.addQuadCurve(to: end, controlPoint: tip)
        }

        var pathTransform  = CGAffineTransform.identity
        pathTransform = pathTransform.translatedBy(x: 0, y: -(rect.height-pentagonPath.bounds.height)/2)
        pentagonPath.apply(pathTransform)

        UIColor.black.set()
        pentagonPath.stroke()
        pentagonPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/pentagon.png)

<br><br>

#### 6. 별(Star)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let starPath = UIBezierPath()

        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        let numberOfPoints = CGFloat(5.0)
        let numberOfLineSegments = Int(numberOfPoints * 2.0)
        let theta = .pi / numberOfPoints
        let circumscribedRadius = center.x
        let outerRadius = circumscribedRadius * 1.039
        let excessRadius = outerRadius - circumscribedRadius
        let innerRadius = CGFloat(outerRadius * 0.55)

        let leftEdgePointX = (center.x + cos(4.0 * theta) * outerRadius) + excessRadius
        let horizontalOffset = leftEdgePointX / 2.0

        let offsetCenter = CGPoint(x: center.x - horizontalOffset, y: center.y)

        var initPoint: CGPoint?

        for i in 0..<numberOfLineSegments {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let pointX = offsetCenter.x + cos(CGFloat(i) * theta) * radius
            let pointY = offsetCenter.y + sin(CGFloat(i) * theta) * radius
            let point = CGPoint(x: pointX, y: pointY)
            if i == 0 {
                starPath.move(to: point)
                initPoint = point
            } else {
                starPath.addLine(to: point)
            }
        }
        if let initPoint = initPoint {
            starPath.addLine(to: initPoint)
        }

        var pathTransform  = CGAffineTransform.identity
        pathTransform = pathTransform.translatedBy(x: center.x, y: center.y)
        pathTransform = pathTransform.rotated(by: CGFloat(-.pi / 2.0))
        pathTransform = pathTransform.translatedBy(x: -center.x, y: -center.y)

        starPath.apply(pathTransform)

        UIColor.black.set()
        starPath.stroke()
        starPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/star.png)

<br><br>

#### 7. 하트(Heart)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let heartPath = UIBezierPath()

        let scaledRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        heartPath.move(to: CGPoint(x: scaledRect.width/2, y: scaledRect.height))
        heartPath.addCurve(
            to: CGPoint(
                x: scaledRect.origin.x,
                y: scaledRect.origin.y + (scaledRect.size.height/4)),
            controlPoint1:CGPoint(
                x: scaledRect.origin.x + (scaledRect.size.width/2),
                y: scaledRect.origin.y + (scaledRect.size.height*4/4)) ,
            controlPoint2: CGPoint(
                x: scaledRect.origin.x,
                y: scaledRect.origin.y + (scaledRect.size.height/2)) )
        heartPath.addArc(
            withCenter: CGPoint(
                x: scaledRect.origin.x + (scaledRect.size.width/4),
                y: scaledRect.origin.y + (scaledRect.size.height/4)),
            radius: (scaledRect.size.width/4),
            startAngle: CGFloat(Double.pi),
            endAngle: 0,
            clockwise: true)
        heartPath.addArc(
            withCenter: CGPoint(
                x: scaledRect.origin.x + (scaledRect.size.width * 3/4),
                y: scaledRect.origin.y + (scaledRect.size.height/4)),
            radius: (scaledRect.size.width/4),
            startAngle: CGFloat(Double.pi),
            endAngle: 0,
            clockwise: true)
        heartPath.addCurve(
            to: CGPoint(
                x: scaledRect.width/2,
                y: scaledRect.origin.y + scaledRect.size.height),
            controlPoint1: CGPoint(
                x: scaledRect.origin.x + scaledRect.size.width,
                y: scaledRect.origin.y + (scaledRect.size.height/2)),
            controlPoint2: CGPoint(
                x: scaledRect.origin.x + (scaledRect.size.width/2),
                y: scaledRect.origin.y + (scaledRect.size.height*4/4)) )

        UIColor.black.set()
        heartPath.stroke()
        heartPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/heart.png)

<br><br>

#### 8. 말풍선(Bubble)

```swift
class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let bubblePath = UIBezierPath()

        let bubbleSize = rect.width / 5
        var vertex = bubbleSize/3
        if vertex < 5 {
            vertex = 5
        }
        if vertex > 15 {
            vertex = 15
        }
        bubblePath.move(to: CGPoint(x: rect.width - bubbleSize, y: rect.height - vertex))
        bubblePath.addLine(to: CGPoint(x: rect.width/2 + vertex, y: rect.height - vertex))
        bubblePath.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
        bubblePath.addLine(to: CGPoint(x: rect.width/2 - vertex, y: rect.height - vertex))
        bubblePath.addLine(to: CGPoint(x: bubbleSize, y: rect.height - vertex))
        bubblePath.addCurve(to: CGPoint(x: 0, y: rect.height - bubbleSize*2), controlPoint1: CGPoint(x: 0, y: rect.height - vertex), controlPoint2: CGPoint(x: 0, y: rect.height - vertex))
        bubblePath.addLine(to: CGPoint(x: 0, y: rect.height - bubbleSize*2))
        bubblePath.addLine(to: CGPoint(x: 0, y: bubbleSize))
        bubblePath.addCurve(to: CGPoint(x: bubbleSize, y: 0), controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 0, y: 0))
        bubblePath.addLine(to: CGPoint(x: bubbleSize, y: 0))
        bubblePath.addLine(to: CGPoint(x: rect.width - bubbleSize, y: 0))
        bubblePath.addCurve(to: CGPoint(x: rect.width, y: bubbleSize), controlPoint1: CGPoint(x: rect.width, y: 0), controlPoint2: CGPoint(x: rect.width, y: 0))
        bubblePath.addLine(to: CGPoint(x: rect.width, y: bubbleSize))
        bubblePath.addLine(to: CGPoint(x: rect.width, y: rect.height - bubbleSize*2))
        bubblePath.addCurve(to: CGPoint(x: rect.width - bubbleSize, y: rect.height - vertex), controlPoint1: CGPoint(x: rect.width, y: rect.height - vertex), controlPoint2: CGPoint(x: rect.width, y: rect.height - vertex))

        UIColor.black.set()
        bubblePath.stroke()
        bubblePath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/bubble.png)

<br><br>

#### 9. 오른쪽 채팅 말풍선(Right Chat Bubble)

```swift
class Example: UIView {

    private let cornerDistance: CGFloat = 8
    private let cornerRadius: CGFloat = 2

    private let bubbleCornerDistance: CGFloat = 4

    private let bubbleY: CGFloat = 4
    private let bubbleSize: CGFloat = 6
    private let bubbleDistance: CGFloat = 3
    private let bubbleRadius: CGFloat = 1

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let chatPath = UIBezierPath()

        // Start Top Right Point
        chatPath.move(to: CGPoint(x: rect.width - self.cornerDistance - self.bubbleSize, y: 0))

        // Top Right Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleCornerDistance - self.bubbleSize, y: 0))

        chatPath.addCurve(
            to: CGPoint(
                x: rect.width - self.bubbleSize,
                y: self.bubbleCornerDistance),
            controlPoint1:CGPoint(
                x: rect.width - self.bubbleSize - 1,
                y: 1),
            controlPoint2: CGPoint(
                x: rect.width - self.bubbleSize - 1,
                y: 1)
        )

        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleSize, y: self.bubbleCornerDistance))

        // Bubble Top Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleSize, y: self.bubbleCornerDistance + self.bubbleY))
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleDistance, y: self.bubbleCornerDistance + self.bubbleY))

        chatPath.addCurve(
            to: CGPoint(
                x: rect.width - self.bubbleDistance,
                y: self.bubbleCornerDistance + self.bubbleY + self.bubbleDistance),
            controlPoint1:CGPoint(
                x: rect.width,
                y: self.bubbleCornerDistance + self.bubbleY - self.bubbleRadius),
            controlPoint2: CGPoint(
                x: rect.width,
                y: self.bubbleCornerDistance + self.bubbleY + self.bubbleRadius)
        )

        // Bubble Bottom Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleDistance, y: self.bubbleCornerDistance + self.bubbleY + self.bubbleDistance))
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleSize, y: self.bubbleCornerDistance + self.bubbleY + self.bubbleSize))

        // Bottom Right Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.bubbleSize, y: rect.height - self.cornerDistance))

        chatPath.addCurve(
            to: CGPoint(
                x: rect.width - self.cornerDistance - self.bubbleSize,
                y: rect.height),
            controlPoint1:CGPoint(
                x: rect.width - self.bubbleSize - self.cornerRadius + 1,
                y: rect.height - self.cornerRadius),
            controlPoint2: CGPoint(
                x: rect.width - self.bubbleSize - self.cornerRadius,
                y: rect.height - self.cornerRadius + 1)
        )

        chatPath.addLine(to: CGPoint(x: rect.width - self.cornerDistance - self.bubbleSize, y: rect.height))

        // Bottom Left Point
        chatPath.addLine(to: CGPoint(x: self.cornerDistance, y: rect.height))

        chatPath.addCurve(
            to: CGPoint(
                x: 0,
                y: rect.height - self.cornerDistance),
            controlPoint1:CGPoint(
                x: self.cornerRadius,
                y: rect.height - self.cornerRadius + 1),
            controlPoint2: CGPoint(
                x: self.cornerRadius - 1,
                y: rect.height - self.cornerRadius)
        )

        chatPath.addLine(to: CGPoint(x: 0, y: rect.height - self.cornerDistance))

        // Top Left Point
        chatPath.addLine(to: CGPoint(x: 0, y: self.cornerDistance))

        chatPath.addCurve(
            to: CGPoint(
                x: self.cornerDistance,
                y: 0),
            controlPoint1:CGPoint(
                x: self.cornerRadius - 1,
                y: self.cornerRadius),
            controlPoint2: CGPoint(
                x: self.cornerRadius,
                y: self.cornerRadius - 1)
        )

        chatPath.addLine(to: CGPoint(x: self.cornerDistance, y: 0))

        // Initial Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.cornerDistance - self.bubbleSize, y: 0))

        UIColor.black.set()
        chatPath.stroke()
        chatPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/rightBubble.png)

<br><br>

#### 10. 왼쪽 채팅 말풍선(Left Chat Bubble)

```swift
class Example: UIView {

    private let cornerDistance: CGFloat = 8
    private let cornerRadius: CGFloat = 2

    private let bubbleCornerDistance: CGFloat = 4

    private let bubbleY: CGFloat = 4
    private let bubbleSize: CGFloat = 6
    private let bubbleDistance: CGFloat = 3
    private let bubbleRadius: CGFloat = 1

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let chatPath = UIBezierPath()

        // Start Top Right Point
        chatPath.move(to: CGPoint(x: self.cornerDistance + self.bubbleSize, y: 0))

        // Top Right Point
        chatPath.addLine(to: CGPoint(x: rect.width - self.cornerDistance, y: 0))

        chatPath.addCurve(
            to: CGPoint(
                x: rect.width,
                y: self.cornerDistance),
            controlPoint1:CGPoint(
                x: rect.width - self.cornerRadius,
                y: self.cornerRadius),
            controlPoint2: CGPoint(
                x: rect.width - self.cornerRadius,
                y: self.cornerRadius)
        )

        chatPath.addLine(to: CGPoint(x: rect.width, y: self.cornerDistance))

        // Bottom Right Point
        chatPath.addLine(to: CGPoint(x: rect.width, y: rect.height - self.cornerDistance))

        chatPath.addCurve(
            to: CGPoint(
                x: rect.width - self.cornerDistance,
                y: rect.height),
            controlPoint1:CGPoint(
                x: rect.width - self.cornerRadius,
                y: rect.height - self.cornerRadius),
            controlPoint2: CGPoint(
                x: rect.width - self.cornerRadius,
                y: rect.height - self.cornerRadius)
        )

        chatPath.addLine(to: CGPoint(x: rect.width - self.cornerDistance, y: rect.height))

        // Bottom Left Point
        chatPath.addLine(to: CGPoint(x: self.cornerDistance + self.bubbleSize, y: rect.height))

        chatPath.addCurve(
            to: CGPoint(
                x: self.bubbleSize,
                y: rect.height - self.cornerDistance),
            controlPoint1:CGPoint(
                x: self.cornerRadius + self.bubbleSize,
                y: rect.height - self.cornerRadius),
            controlPoint2: CGPoint(
                x: self.cornerRadius + self.bubbleSize,
                y: rect.height - self.cornerRadius)
        )

        chatPath.addLine(to: CGPoint(x: self.bubbleSize, y: rect.height - self.cornerDistance))

        // Bubble Bottom Point
        chatPath.addLine(to: CGPoint(x: self.bubbleSize, y: self.bubbleCornerDistance + self.bubbleY + self.bubbleSize))
        chatPath.addLine(to: CGPoint(x: self.bubbleDistance, y: self.bubbleCornerDistance + self.bubbleY + self.bubbleDistance))

        chatPath.addCurve(
            to: CGPoint(
                x: self.bubbleDistance,
                y: self.bubbleCornerDistance + self.bubbleY),
            controlPoint1:CGPoint(
                x: 0,
                y: self.bubbleCornerDistance + self.bubbleY + self.bubbleRadius),
            controlPoint2: CGPoint(
                x: 0,
                y: self.bubbleCornerDistance + self.bubbleY - self.bubbleRadius)
        )

        // Bubble Top Point
        chatPath.addLine(to: CGPoint(x: self.bubbleDistance, y: self.bubbleCornerDistance + self.bubbleY))
        chatPath.addLine(to: CGPoint(x: self.bubbleSize, y: self.bubbleCornerDistance + self.bubbleY))

        // Top Left Point
        chatPath.addLine(to: CGPoint(x: self.bubbleSize, y: self.bubbleCornerDistance))

        chatPath.addCurve(
            to: CGPoint(
                x: self.bubbleCornerDistance + self.bubbleSize,
                y: 0),
            controlPoint1:CGPoint(
                x: self.bubbleSize + 1,
                y: 1),
            controlPoint2: CGPoint(
                x: self.bubbleSize + 1,
                y: 1)
        )

        chatPath.addLine(to: CGPoint(x: self.bubbleCornerDistance + self.bubbleSize, y: 0))

        // Initial Point
        chatPath.addLine(to: CGPoint(x: self.cornerDistance + self.bubbleSize + self.bubbleSize, y: 0))

        UIColor.black.set()
        chatPath.stroke()
        chatPath.close()
    }
}
```

![Alt Text](/tec/images/2018/11/bezierPath/leftBubble.png)

<br><br>
