---
layout:     post
title:      swift PHAsset Permission, fetchAssetCollections, fetchAssets, requestImage, progress
date:       2018-11-22 08:00:00
summary:    Swift PHAsset을 사용해서 권한획득, Album List, Picture List, Get Image, iCloud Download Progress 확인하기
categories: swift
---

[예제 다운](/tec/images/2018/11/imageAsset/SimpleImagePicker.zip)

#### 1. Info.plist

Privacy - Photo Library Usage Description을 추가한다.

![Alt Text](/tec/images/2018/11/imageAsset/info.png)


#### 2. import

Photos 를 import한다.

```Swift

import Photos

```

#### 3. PHPhotoLibraryChangeObserver

PHPhotoLibraryChangeObserver 를 컨트롤러에 등록한다.
PHPhotoLibraryChangeObserver 는 이미지가 추가되거나 삭제되거나 수정됬을때 호출이 된다.
deinit될때 해제되어야 한다.

```Swift

class ViewController: UIViewController {

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
    }  
}

// MARK: PHPhotoLibraryChangeObserver
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // fetchData
    }
}

```

#### 4. 이미지 Authorization

이미지 권한 체크를 한다.

```Swift

if PHPhotoLibrary.authorizationStatus() == .authorized {
    // fetchData
} else if PHPhotoLibrary.authorizationStatus() == .denied {
    print("Permission Denied")
} else {
    PHPhotoLibrary.requestAuthorization() { (status) in
        switch status {
        case .authorized:
            // fetchData
            break
        default:
            print("Permission Denied")
        }
    }
}

```

#### 5. 앨범 리스트 가져오기

앨범 리스트를 가져온다.


```Swift

PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: PHFetchOptions()).enumerateObjects { (collection, _, _) in
    let count = PHAsset.fetchAssets(in: collection, options: nil).count // 앨범안의 사진 갯수
    print(collection); // 앨범
}

```

#### 6. 앨범을 통해 사진을 가져오기

앨범을 통해 사진 리스트를 가져온다.

```Swift

var assets = [PHAsset]()
PHAsset.fetchAssets(in: collection, options: PHFetchOptions()).enumerateObjects({ (asset, _, _) in
    assets.append(asset)
})
print(assets);

```

#### 7. PHAsset의 이미지 추출

PHCachingImageManager를 이용하여 PHAsset의 이미지를 추출한다.

```Swift

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else { fatalError() }

    let imageRequestOptions = PHImageRequestOptions()
    imageRequestOptions.isSynchronous = true
    imageRequestOptions.resizeMode = .fast
    imageRequestOptions.isNetworkAccessAllowed = true
    imageRequestOptions.deliveryMode = .highQualityFormat

    let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    PHCachingImageManager().requestImage(for: self.assets[indexPath.row], targetSize: size, contentMode: .aspectFit, options: imageRequestOptions, resultHandler: { (image, _) in
        cell.image = image
    })

    return cell
}

```

#### 8. PHAsset의 이미지를 가져올때 progress 숫자 표시하기

PHImageRequestOptions을 이용하여 iCloud에 있는 이미지를 가져올때 progress를 표시할수 있게 한다.

```Swift

let imageRequestOptions = PHImageRequestOptions()
imageRequestOptions.isSynchronous = true
imageRequestOptions.deliveryMode = .highQualityFormat
imageRequestOptions.isNetworkAccessAllowed = true
imageRequestOptions.progressHandler = { (progress, error, stop, info) in
    DispatchQueue.main.async {
        self.label.text = String(format: "%.1f", progress*100).appending("%")
    }
}
PHCachingImageManager().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: imageRequestOptions, resultHandler: { (image, _) in
    DispatchQueue.main.async {
        self.imageView.image = image
        self.activityIndicatorView.isHidden = true
        self.label.isHidden = true
    }
})

```

![Alt Text](/tec/images/2018/11/imageAsset/progress.png)


[예제 다운](/tec/images/2018/11/imageAsset/SimpleImagePicker.zip)
