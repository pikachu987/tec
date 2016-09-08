---
layout:     post
title:      Swift Firebase Facebook Login
date:       2016-09-07 20:30:00
summary:    Firebase Facebook Login 페이스북 로그인
categories: swift
---



해당 소스는 깃허브페이지
[github](https://github.com/pikachu987/TIL/tree/master/swift%202.2/LoginF)
에 올려져 있다.


여기서는 Swift2로 Facebook 로그인 하는 과정과 예제를 살펴보겠다.

가장 먼저 앱을 만들어 보자.

![Alt text](/tec/imagesswift_fbLogin/01.png)

![Alt text](/tec/imagesswift_fbLogin/02.png)

<br>
그리고 [developer.facebook](http://developer.facebook.com)에 들어가서 새 앱을 만든다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/03.png)

<br>
IOS를 클릭!! 한다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/04.png)

<br>
Facebook 앱 네임을 넣는데 FB나 Facebook 관련 글자는 써지지가 않는다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/05.png)

<br>
연락처이메일과 카테고리를 선택후 앱 ID를 만든다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/06.png)

<br><br>

![Alt text](/tec/imagesswift_fbLogin/07.png)

![Alt text](/tec/imagesswift_fbLogin/08.png)

<br>
이 값들은 Swift앱 내의 info.plist파일 안에 넣어야 하는내용이므로 어딘가에 복사해두기로 한다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/09.png)

<br>
하단으로 내려가면 Swift APP Bundle적는 부분이 있다. 자신이 만든 앱 Bundle와 맞춰서 적으면 된다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/10.png)

<br>
[console.firebase](https://console.firebase.google.com/)에 들어가서 새 프로젝트를 만든다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/11.png)

![Alt text](/tec/imagesswift_fbLogin/12.png)

<br>
번들을 적는다.
<br><br>

![Alt text](/tec/imagesswift_fbLogin/14.png)
다시 페이스북으로 간 다음 대시보드에서 앱 ID와 앱 시크릿코드를 확인한다.

<br />

![Alt text](/tec/imagesswift_fbLogin/13.png)

파이어베이스 Auth에 들어가서 로그인 방법을 클릭한다. 그러면 페이스북이 두둥! 있을것이다.

![Alt text](/tec/imagesswift_fbLogin/15.png)

페이스북을 사용설정한 뒤 페이스북에서 확인한 앱ID와 앱 시크릿코드를 확인한 다음 OAuth 리디렉션 URI를 복사한다.

![Alt text](/tec/imagesswift_fbLogin/16.png)

이제 마지막부분이다! 페이스북으로 가서 +제품추가를 클릭한 뒤

![Alt text](/tec/imagesswift_fbLogin/17.png)

Facebook 로그인 시작하기 버튼을 누른다.

![Alt text](/tec/imagesswift_fbLogin/18.png)

그리고 복사해두었던 리디렉션 URI를 붙이고 하단에 버튼을 누른다.

![Alt text](/tec/imagesswift_fbLogin/19.png)

파이어베이스에 들어가서 GoogleService-info.plist파일을다운 받고 해당 파일을 앱 폴더안 info.plist옆에 넣는다.

![Alt text](/tec/imagesswift_fbLogin/21.png)

그리고 앱 Podfile에

~~~~
use_frameworks!
pod 'Firebase'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'FBSDKCoreKit'
pod 'FBSDKShareKit'
pod 'FBSDKLoginKit'
~~~~

을 넣고 pod install 을 한다.

해당 부분은 [cocoapods](https://cocoapods.org/) 참조

![Alt text](/tec/imagesswift_fbLogin/20.png)

그리고 앱을 실행 후 Info.plist파일 - 소스보기를 누른다. 아까 페이스북에서 봤던 코드 붙여넣기!!!

~~~~
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>fb{ID}</string>
            </array>
        </dict>
    </array>
    <key>FacebookAppID</key>
    <string>{ID}</string>
    <key>FacebookDisplayName</key>
    <string>LoginF</string>
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>fbapi</string>
        <string>fb-messenger-api</string>
        <string>fbauth2</string>
        <string>fbshareextension</string>
    </array>
~~~~


![Alt text](/tec/imagesswift_fbLogin/22.png)

앱 딜리게이트로 가서 간단하게

~~~~
import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        //firebase
        FIRApp.configure()

        //facebook
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}
~~~~

이렇게 코드를 넣어주자!!!

![Alt text](/tec/images/swift_fbLogin/23.png)

그리고 스토리보드에서 UIButton을 하나 만들고 페이스북과 비슷한 background를 넣고 png이미지 파일을 구해서 넣어주자(디자인은 상관없슴! 사실 아무 버튼만 넣으면 상관 x)

![Alt text](/tec/imagesswift_fbLogin/24.png)

UIViewController에서 button에 action을 받자. 그리고 코드를 넣어준다.

~~~~
let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile"], fromViewController: self, handler: { (result, error) in
            if error != nil{
                print("Facebook login failed. Error \(error)")
            } else if result.isCancelled {
                print("Facebook login isCancelled. result \(result.token)")
            } else {
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        if let value = user?.email{
                            //
                        }
                        if let value = user?.displayName{
                            //
                        }
                        if let value = user?.uid{
                            //
                        }
                        if let value = user?.photoURL{
                            //self.imageView.image = UIImage(data: NSData(contentsOfURL: value)!)
                        }
                    }
                }
            }
        })
~~~~

엄청 간단하다...

![Alt text](/tec/imagesswift_fbLogin/25.jpeg)

실행을 시키면 잘 나오는것을 확인 할 수 있다.

처음에 이걸 왜 이리 힘들었는지....

나는 구글로그인, 카톡로그인을 구현한 다음 페북로그인을 계속 넣으려고 했지만 실패....

구글 로그인을 빼니까 카톡, 페북로그인이 다 잘됨(아직 왜인지 모른다...)
