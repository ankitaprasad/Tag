//
//  GalleryViewController.swift
//  Tag
//
//  Created by Ankita Prasad on 8/21/15.
//  Copyright (c) 2015 Ankita Prasad. All rights reserved.
//

import UIKit
import Photos

let reuseIdentifier = "PhotoCell"

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var assetCollection : PHAssetCollection!
    var photoAsset : PHFetchResult!
    var thumbnailSize:CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(PhotoThumbnail.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let fetchOptions = PHFetchOptions()

        //var status = PHPhotoLibrary.authorizationStatus()
        let photoCollection = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: fetchOptions) as PHFetchResult
        if let firstObj1:AnyObject = photoCollection.firstObject {
            assetCollection = firstObj1 as! PHAssetCollection
            photoAsset = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
       // var screenWidth = UIScreen.mainScreen().applicationFrame.width
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.itemSize = CGSizeMake(123, 123)
            let cellSize = layout.itemSize
            thumbnailSize = CGSizeMake(cellSize.width, cellSize.height)
            
        }
        photoAsset = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationVC = segue.destinationViewController as? ImageViewController {
            let pictureViewCell = sender as! PhotoThumbnail
            let indexPath = collectionView?.indexPathForCell(pictureViewCell)
            destinationVC.displayImageAsset = photoAsset
            destinationVC.assetCollection = assetCollection
            destinationVC.index = indexPath!.item
            
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if(photoAsset != nil)
        {
            return photoAsset.count
        }
        return 0;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        let asset : PHAsset = photoAsset[indexPath.item] as! PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: {
            (result, info) in
            cell.selectThumbnail(result!)
        })
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
