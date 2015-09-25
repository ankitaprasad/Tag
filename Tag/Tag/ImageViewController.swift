//
//  ImageViewController.swift
//  Tag
//
//  Created by Ankita Prasad on 8/25/15.
//  Copyright (c) 2015 Ankita Prasad. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //displayImageView.image = displayImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayImageAsset : PHFetchResult!
    var assetCollection : PHAssetCollection!
    var index : Int!

    @IBOutlet var displayImageView: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
