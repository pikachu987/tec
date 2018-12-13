---
layout:     post
title:      swift LifeCycle
date:       2018-12-09 08:00:00
summary:    Swift App LifeCycle과 ViewController의 LifeCycle
categories: swift
---

### App LifeCycle

UIKit 앱은 항상 5가지 상태중의 하나에 있다.

- Not Running: 앱이 실행되지 않은 상태

- Inactive: 앱이 실행중인상태지만 이벤트없음

- Active: 앱이 실행중이며 이벤트가 발생

- Background: 앱이 백그라운드에 있지만 실행되는 코드가 있음

- Suspened: 앱이 백그라운드에 있고 실행되는 코드가 없음

![Alt Text](/tec/images/2018/12/lifeCycle/appLifeCycle.png)

<br><br>

5가지의 상태들의 이벤트를 관리하는 곳이 UIApplicationDelegate 프로토콜이다.

- Launch: 앱이 실행되지 않은 상태에서 비활성 또는 백그라운드 상태로 전환된다.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
}
```

- Activation: 앱이 비활성 상태에서 활성 상태로 전환이 된다.

```swift
func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
```

> `applicationDidBecomeActive(_:)` 는 앱이 현재 포그라운드 상태에 있다는 것을 알려준다.
>
> 앱이 백그라운드에서 이미 실생중이면 `applicationDidBecomeActive(_:)`을 호출하기 전에 `applicationWillEnterForeground(_:)`를 먼저 호출한다.

- Deactivation: 앱이 활성 상태에서 비활성 상태로 전환된다.

```swift
func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

}
```

- Background execution: 앱이 비활성 상태 또는 실행되지 않는 상태에서 백그라운드 상태로 전환된다.

```swift
func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}
```

- Termination: 앱이 실행중 상태에서 실행중지 상태로 전환된다.

```swift
func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
```

### ViewController LifeCycle

 UIViewController는 가장 먼저

```swift
override func loadView() {
    super.loadView()

}
```

가 호출이 되고

```swift
override func viewDidLoad() {
    super.viewDidLoad()

}
```

다음 `viewDidLoad()`가 호출이 된다.


![Alt Text](/tec/images/2018/12/lifeCycle/viewLifeCycle.png)

- `viewWillAppear(:_)` 는 화면이 보일 예정임을 알린다.

```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

}
```

- `viewDidAppear(:_)` 는 화면이 보였다는것을 알린다.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

}
```

- `viewWillDisappear(:_)` 는 화면이 보이지 않으려고 하고 있다는 것을 알린다.

```swift
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

}
```

- `viewDidDisappear(:_)` 는 화면이 보이지 않게 된 것을 알린다.

```swift
override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

}
```

> class에서는 메모리가 해제되었을때 deinit을 호출한다.
>
> ```swift
>
> deinit {
>
> }
>
> ```
