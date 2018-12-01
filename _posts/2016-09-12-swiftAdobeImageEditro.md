---
layout:     post
title:      Swift Adobe Image Editor
date:       2016-09-12 08:30:00
summary:    Adobe 이미지 에디터 사용해보기
categories: swift
---



해당 소스는 깃허브페이지
[github](https://github.com/pikachu987/TIL/tree/master/swift2/AdobeImageEditor)
에 올려져 있다.



<br>

[동영상보기](https://www.youtube.com/embed/8VzEs-gEeEQ)
[![동영상 클릭](https://pikachu987.github.io/tec/images/swift_adobeEditor/30.png)](https://www.youtube.com/embed/8VzEs-gEeEQ "editor")


![Alt text](https://pikachu987.github.io/tec/images/swift_adobeEditor/1.png)

우리가 일단 Adobe 이미지 에디터를 사용려면 당연히 Adobe 개발자 사이트 [adobe](https://creativesdk.adobe.com/downloads.html) 에 회원가입을 해야 한다.
상단에 보면 Downloads와 My Apps에만 들어갈 것이다.



![Alt text](/tec/images/2016/09/swift_adobeEditor/2.png)

일단 [Downloads](https://creativesdk.adobe.com/downloads.html) 에 들어가서 STATIC FRAMEWORKS(DEPRECATED)를 클릭해서 다운받자.


![Alt text](/tec/images/2016/09/swift_adobeEditor/3.png)

다운받으면 framework가 엄청 많다...

![Alt text](/tec/images/2016/09/swift_adobeEditor/4.png)

우리한테 필요한 것은 이 4개이다. 그런데 .bundle는 어디 있을까?
정답은 .framework를 들어가면 .bundle이 있을것이다. 복붙해서 이렇게 4개를 만들자.

![Alt text](/tec/images/2016/09/swift_adobeEditor/5.png)

해당 IOS앱 폴더에 해당 4개를 넣자.

![Alt text](/tec/images/2016/09/swift_adobeEditor/6.png)

그리고 4개를 드래그해서 xCode상에 넣자.

![Alt text](/tec/images/2016/09/swift_adobeEditor/7.png)

TARGETS에서 General에서 Linked Frameworks and Libraies 에 보면 이런식으로 4개가 생겼을 것이다.
여기서 +를 눌러서 추가한다.

![Alt text](/tec/images/2016/09/swift_adobeEditor/8.png)

이런식으로 하나씩하나씩 추가를 해서

![Alt text](/tec/images/2016/09/swift_adobeEditor/9.png)

이렇게 나오도록 추가를 한다.

![Alt text](/tec/images/2016/09/swift_adobeEditor/10.png)

이제 Bulid Settings에 들어가서 Linking를 찾는다.

![Alt text](/tec/images/2016/09/swift_adobeEditor/11.png)

Other Linker Flags에 이런식으로 적어준다.

![Alt text](/tec/images/2016/09/swift_adobeEditor/12.png)

브릿지헤더에서 이런식으로 적어준다.

~~~~

//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#ifndef AdobeCreative_Bridging_Header_h
#define AdobeCreative_Bridging_Header_h

#import <AdobeCreativeSDKCore/AdobeCreativeSDKCore.h>
#import <AdobeCreativeSDKImage/AdobeCreativeSDKImage.h>

#endif /* AdobeCreative_Bridging_Header_h */


~~~~

![Alt text](/tec/images/2016/09/swift_adobeEditor/13.png)

[MyApps](https://creativesdk.adobe.com/myapps.html) 에 들어가서 새로운 앱을 만든다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/14.png)

여기서 중요한건 SECRET를 꼭 복사해놓자.


![Alt text](/tec/images/2016/09/swift_adobeEditor/15.png)

AppDelegate.swift에 이런식으로 ID와 SECRET를 한줄 추가한다.

~~~~

//adobe
        AdobeUXAuthManager.sharedManager().setAuthenticationParametersWithClientID("ea2bb582861f48d8970f0155a54fee22", withClientSecret: "0ce233b2-3f4a-4851-8307-934930cbcc1e")

~~~~

![Alt text](/tec/images/2016/09/swift_adobeEditor/16.png)

(하단부분에 총 소스를 올려두겠다.)


UIViewController에

~~~~

UIImagePickerControllerDelegate, UINavigationControllerDelegate, AdobeUXImageEditorViewControllerDelegate

~~~~

를 추가하자.

UIImagePickerControllerDelegate와 UINavigationControllerDelegate는 카메라, 사진 선택하는데 필요한 딜리게이트이고
AdobeUXImageEditorViewControllerDelegate는 AdobeImageEditor하는데 필요한 딜리게이트이다.

![Alt text](/tec/images/2016/09/swift_adobeEditor/17.png)

카메라, 사진에 필요한 Picker를 변수로 지정.


![Alt text](/tec/images/2016/09/swift_adobeEditor/18.png)

picker설정을 한다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/19.png)

버튼이벤트를 준다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/20.png)

picker 딜리게이트 관련 메소드이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/21.png)

여기는 adobe 관련 설정을 한다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/22.png)

adobe에서 완성된 이미지를 받아온다.

UIViewController 소스이다.

~~~~

//
//  ViewController.swift
//  AdobeImageEditor
//
//  Created by guanho on 2016. 9. 7..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AdobeUXImageEditorViewControllerDelegate {



    //이미지 피커
    let picker = UIImagePickerController()

    @IBOutlet var mainView: UIView!
    @IBOutlet var imageView: UIImageView!
    let eatImage = UIImage(named: "eat.jpg")




    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.allowsEditing = true
        picker.delegate = self
    }



    @IBAction func btnAction(sender: AnyObject) {
        let alert = UIAlertController(title:"",message:"이미지 선택", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title:"카메라",style: .Default,handler:{(alert) in
            self.imageCallback(UIImagePickerControllerSourceType.Camera)
        }))
        alert.addAction(UIAlertAction(title:"사진첩",style: .Default,handler:{(alert) in
            self.imageCallback(UIImagePickerControllerSourceType.PhotoLibrary)
        }))
        alert.addAction(UIAlertAction(title:"치킨이미지",style: .Default,handler:{(alert) in
            self.photoEditorStart(self.eatImage)
        }))
        self.presentViewController(alert, animated: false, completion: {(_) in })
    }



    //이미지 콜백
    func imageCallback(sourceType : UIImagePickerControllerSourceType){
        picker.sourceType = sourceType
        presentViewController(picker, animated: false, completion: nil)
    }
    //이미지 끝
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //이미지 받아오기
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        dismissViewControllerAnimated(true, completion: {(_) in
            self.photoEditorStart(newImage)
        })
    }



    //이미지 에디터 시작
    func photoEditorStart(image: UIImage!){
        dispatch_async(dispatch_get_main_queue()) {
            //AdobeImageEditor 설정
            AdobeImageEditorCustomization.setToolOrder([
                kAdobeImageEditorEnhance,        /* Enhance */
                kAdobeImageEditorEffects,        /* Effects */
                kAdobeImageEditorStickers,       /* Stickers */
                kAdobeImageEditorOrientation,    /* Orientation */
                kAdobeImageEditorCrop,           /* Crop */
                kAdobeImageEditorColorAdjust,    /* Color */
                kAdobeImageEditorLightingAdjust, /* Lighting */
                kAdobeImageEditorSharpness,      /* Sharpness */
                kAdobeImageEditorDraw,           /* Draw */
                kAdobeImageEditorText,           /* Text */
                kAdobeImageEditorRedeye,         /* Redeye */
                kAdobeImageEditorWhiten,         /* Whiten */
                kAdobeImageEditorBlemish,        /* Blemish */
                kAdobeImageEditorBlur,           /* Blur */
                kAdobeImageEditorMeme,           /* Meme */
                kAdobeImageEditorFrames,         /* Frames */
                kAdobeImageEditorFocus,          /* TiltShift */
                kAdobeImageEditorSplash,         /* ColorSplash */
                kAdobeImageEditorOverlay,        /* Overlay */
                kAdobeImageEditorVignette        /* Vignette */
                ])

            let adobeViewCtr = AdobeUXImageEditorViewController(image: image)
            adobeViewCtr.delegate = self
            self.presentViewController(adobeViewCtr, animated: true) { () -> Void in

            }
        }
    }



    //AdobeCreativeSDK 이미지 받아옴
    func photoEditor(editor: AdobeUXImageEditorViewController, finishedWithImage image: UIImage?) {
        editor.dismissViewControllerAnimated(true, completion: {(_) in
            let imageWidth = self.mainView.frame.width
            let imageHeight = self.mainView.frame.height

            let rateWidth = (image?.size.width)!/imageWidth
            let rateHeight = (image?.size.height)!/imageHeight

            var widthValue : CGFloat! = imageWidth
            var heightValue : CGFloat! = imageHeight

            if rateWidth > rateHeight{
                heightValue = widthValue * (image?.size.height)! / (image?.size.width)!
            }else{
                widthValue = heightValue * (image?.size.width)! / (image?.size.height)!
            }
            self.imageView.frame = CGRect(x: (imageWidth-widthValue)/2, y: (imageHeight-heightValue)/2, width: widthValue, height: heightValue)
            self.imageView.image = image
        })
    }


    //AdobeCreativeSDK 캔슬
    func photoEditorCanceled(editor: AdobeUXImageEditorViewController) {
        editor.dismissViewControllerAnimated(true, completion: nil)
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



~~~~




미리보기 이미지!

![Alt text](/tec/images/2016/09/swift_adobeEditor/23.png)

첫 화면이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/24.png)

클릭을 하면 선택을 할수있다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/25.png)

이미지 에디터 화면이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/26.png)

크롭화면이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/27.png)

방향전환 화면이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/28.png)

그리기 화면이다.


![Alt text](/tec/images/2016/09/swift_adobeEditor/29.png)

완료후 받아온 이미지이다.


엄청 쉽게 고급기능을 쓸 수 있게 해주는 Adobe이다. 너무 좋은듯하다.
