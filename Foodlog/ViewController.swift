//
//  ViewController.swift
//  Foodlog
//
//  Created by Olga Koschel on 29.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var takenImage: UIImage!
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform, 1.5, 1.5)
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        takenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let pictureSettingsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PictureSettingsViewController") as! PictureSettingsViewController
        
        presentViewController(pictureSettingsViewController, animated: true) { () -> Void in
            pictureSettingsViewController.loadPicture(self.takenImage)
        }
    }

}

