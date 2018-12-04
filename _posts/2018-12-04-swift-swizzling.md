---
layout:     post
title:      swift swizzling 스위즐링
date:       2018-12-04 08:00:00
summary:    Swift swizzling 써보기
categories: swift
---

#### Method Swizzling

스위즐링은 런타임에 해당 메서드를 내가 원하는 메서드로 바꿀 수 있다.


```Swift

extension UIViewController {
    @objc private func customViewWillAppear(_ animated: Bool) {
        print("customViewWillAppear 호출")

    }

    static let swizzleMethodWillAppear: Void = {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(customViewWillAppear(_:))

        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)

        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
}

```


```Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UIViewController.swizzleMethodWillAppear

        return true
    }
}

```

이렇게 하면 UIViewController에서 viewWillAppear가 호출이 될때 내가 만든 메서드가 호출이 된다.

#### 단점

1. firebase, analytics 등의 프레임워크에서 스위즐링을 이미 사용하고 있을수 있다.
2. 디버깅하기가 어려워진다.
