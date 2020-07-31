//
//  ImageListView.swift
//  MyChat
//
//  Created by dexjoke on 6/30/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import Photos

class ImageListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    private let CELL_IDENTIFIER = "ImageCell"
    private let maxItemInRow = 4
    var imageArray=[UIImage]()
    
    static func create() -> ImageListView {
        let view: ImageListView = ViewUtils.loadNib(name: "ImageListView")
        view.initialize()
        return view
    }
    
    func initialize() {
        let nib = UINib(nibName: CELL_IDENTIFIER, bundle: nil)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: CELL_IDENTIFIER)
        imagesCollectionView?.contentInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.imagesCollectionView.delegate = self
        self.imagesCollectionView.dataSource = self
        imagesCollectionView.allowsSelection = false
        grabPhotos()
    }
    
    func grabPhotos(){
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager=PHImageManager.default()
            
            let requestOptions=PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions=PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("You got no photos.")
            }
            print("imageArray count: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.imagesCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! ImageCell
        cell.update(img: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right) * CGFloat(maxItemInRow)) / CGFloat(maxItemInRow)
        return CGSize(width: itemSize, height: itemSize)
    }
}
