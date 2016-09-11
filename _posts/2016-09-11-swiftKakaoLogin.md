---
layout:     post
title:      Swift Kakao Login
date:       2016-09-11 08:30:00
summary:    앞에서 했던 FacebookLogin에서 Kakao Login 카카오톡 로그인 추가하기
categories: swift
---



해당 소스는 깃허브페이지
[github](https://github.com/pikachu987/TIL/tree/master/swift%202.2/LoginFK)
에 올려져 있다.


여기서는 앞서했던 Swift2로 Facebook 로그인 하는 예제에서 카카오 로그인을 추가하는 예제를 살펴보겠다.

![Alt text](/tec/images/swift_kakaoLogin/01.png)

카카오톡 로그인버튼을 한개 만들어주자.

![Alt text](/tec/images/swift_kakaoLogin/02.png)

해당 버튼에 이벤트를 추가

![Alt text](/tec/images/swift_kakaoLogin/03.png)

[developer.kakao](https://developer.kakao.com/) 에 들어가서 새로운 앱을 만들자

![Alt text](/tec/images/swift_kakaoLogin/04.png)

아주아주 간단하개 만들어졌다. 여기서 플랫폼 추가를 누르자.

![Alt text](/tec/images/swift_kakaoLogin/05.png)

번들을 넣고,

![Alt text](/tec/images/swift_kakaoLogin/06.png)

사용자관리에 들어가서 사용 ON을 누른 다음 하단의 텍스트등등을 기록한다. 그리고 저장을 누르자.

![Alt text](/tec/images/swift_kakaoLogin/07.png)

카카오 SDK를 다운받으면 이런 구조로 되어 있다

![Alt text](/tec/images/swift_kakaoLogin/08.png)

framework를 자신의 앱폴더로 이동한 다음 끌어서 앱에 추가한다.

![Alt text](/tec/images/swift_kakaoLogin/19.png)

info.plist 를 마우스 우 클릭해서 Open As > Source Code를 누른다.
그리고 기존 페이스북설정에 카카오톡 설정을 추가한다.

~~~~

<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>fb1607177109583285</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>kakao8e8ab69c7b01eaeebce7d7bc0afc2896</string>
            </array>
        </dict>
    </array>
    <key>FacebookAppID</key>
    <string>1607177109583285</string>
    <key>FacebookDisplayName</key>
    <string>LoginF</string>
    <key>KAKAO_APP_KEY</key>
    <string>8e8ab69c7b01eaeebce7d7bc0afc2896</string>
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>fbapi</string>
        <string>fb-messenger-api</string>
        <string>fbauth2</string>
        <string>fbshareextension</string>
        <string>kakao8e8ab69c7b01eaeebce7d7bc0afc2896</string>
        <string>kakaokompassauth</string>
        <string>storykompassauth</string>
        <string>kakaolink</string>
        <string>kakaotalk-4.5.0</string>
        <string>kakaostory-2.9.0</string>
    </array>

~~~~


![Alt text](/tec/images/swift_kakaoLogin/09.png)

여기서는 브릿지 헤더(bridging header)를 만들어야 한다. 만드는 방법은 마우스 우클릭해서 New File를 누른다.

> 브릿지 헤더란?
> Objective-C 코드를 Swift에서 import만 하면 쓸 수 있게 만들어주는 역활을 한다.

![Alt text](/tec/images/swift_kakaoLogin/10.png)

그리고 C++ File을 누르고

![Alt text](/tec/images/swift_kakaoLogin/11.png)

아무렇게나 이름을 쓴다.

![Alt text](/tec/images/swift_kakaoLogin/12.png)

#### 이때 제일 중요한게 꼭 Create Briding Header를 눌러야 브릿지헤더가 생성이된다!!!!

![Alt text](/tec/images/swift_kakaoLogin/13.png)

생성이 된 모습이다. 나머지 aaa. 으로 시작되는 2개 파일은 삭제해준다.

![Alt text](/tec/images/swift_kakaoLogin/14.png)

생성된 브릿지 헤더에 kakao SDK를 import 해준다.

~~~~

#import <KakaoOpenSDK/KakaoOpenSDK.h>

~~~~

![Alt text](/tec/images/swift_kakaoLogin/15.png)

AppDelegate.swift 파일에 들어가서 Kakao관련 내용을 추가한다.

~~~~

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        //firebase
        FIRApp.configure()


        //facebook
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpenURL(url)
        }
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        //kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpenURL(url)
        }
        return false
    }

~~~~

![Alt text](/tec/images/swift_kakaoLogin/16.png)

이제 아까 만들었던 카카오 버튼 이벤트에 내용을 추가하는 것이다.

~~~~

let session: KOSession = KOSession.sharedSession();
        if session.isOpen() {
            session.close()
        }
        session.presentingViewController = self
        session.openWithCompletionHandler({ (error) -> Void in
            if error != nil{
                print(error.localizedDescription)
            }else if session.isOpen() == true{
                KOSessionTask.meTaskWithCompletionHandler({ (profile , error) -> Void in
                    if profile != nil{
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let kakao : KOUser = profile as! KOUser
                            //String(kakao.ID)
                            if let value = kakao.properties["nickname"] as? String{
                                self.textView.text = "nickname : \(value)\r\n"
                            }
                            if let value = kakao.properties["profile_image"] as? String{
                                self.imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: value)!)!)
                            }
                            if let value = kakao.properties["thumbnail_image"] as? String{
                                self.image2View.image = UIImage(data: NSData(contentsOfURL: NSURL(string: value)!)!)
                            }
                        })
                    }
                })
            }else{
                print("isNotOpen")
            }
        })

~~~~

물론 더 많은 것을 쓸 수 있겠지만 그것들은 자기가 연구해보길.... 카카오 개발자센터에서 쉽게 확인 할 수 있다.

![Alt text](/tec/images/swift_kakaoLogin/17.png)

이미지등등을 외부에서 가져오려면 info.plist파일에 Security라는걸 추가해줘야 한다.

~~~~

<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>

~~~~

![Alt text](/tec/images/swift_kakaoLogin/18.png)

짜잔!!!!! 완성

<br><br>

나는 info.plist에서 페이스북 한개는 잘되고 카카오톡 한개는 잘됬는데 둘이 연동하는법 때문에 좀 많이 어려웠었다.
그래서 카카오톡 추가하기 예제만 하려고 했지만 둘이 연동해서 같이 하는게 더 좋을거라는 생각 때문에 이전에 만들었었던
예제에서 부터 시작을 했다.

아!!!

그리고 페북, 카톡 로그인하기 할 때 아이디값(회원의 고유값) 은

~~~~

페이스북 = user?.uid
카카오톡 = String(kakao.ID)

~~~~

을 쓰면 된다.
