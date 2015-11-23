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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        displayPhoto()
        messageTextField.placeholder = "Include a message (optional)"
    }
    
    @IBOutlet var messageTextField: UITextField!

    var displayImageAsset : PHFetchResult!
    var assetCollection : PHAssetCollection!
    var index : Int!
    var message: String!

    @IBOutlet var displayImageView: UIImageView!
    

    @IBAction func messageBoxEndOnExit(sender: UITextField) {
        message = sender.text
    }
 
    func displayPhoto() {
        let scale : CGFloat = UIScreen.mainScreen().scale
        let screenSize : CGSize = UIScreen.mainScreen().bounds.size
        let targetSize = CGSizeMake(screenSize.width * scale, screenSize.height * scale)
        let imageManager = PHImageManager.defaultManager()
        if let asset = displayImageAsset[index] as? PHAsset{
            var ID = imageManager.requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: nil, resultHandler: {
                (result, info) -> Void in
                self.displayImageView.image = result
            
            })
        }
    }

    
    func createTextField(tapPoint : CGPoint) -> UITextField {
        let textField = UITextField(frame: CGRectMake(tapPoint.x, tapPoint.y+10, 50, 20))
        return textField
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
