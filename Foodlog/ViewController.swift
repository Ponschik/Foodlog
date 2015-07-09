//
//  ViewController.swift
//  Foodlog
//
//  Created by Olga Koschel on 29.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var takenImage: UIImage!
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    
    @IBAction func takePhotoWithAVCamera(sender: AnyObject) {
        // Loop through all the capture devices on this phone
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil {
            beginSession()
        }

    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform, 1.5, 1.5)
        imagePicker.sourceType = .Camera
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
        
//            //Create camera overlay
//            CGRect f = imagePickerController.view.bounds;
//            f.size.height -= imagePickerController.navigationBar.bounds.size.height;
//            CGFloat barHeight = (f.size.height - f.size.width) / 2;
//            UIGraphicsBeginImageContext(f.size);
//            [[UIColor colorWithWhite:0 alpha:.5] set];
//            UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
//            UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
//            UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            
//            UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
//            overlayIV.image = overlayImage;
//            [imagePickerController.cameraOverlayView addSubview:overlayIV];
        
//        var f :CGRect = imagePicker.view.bounds
//        f.size = CGSize(width: f.size.width, height: (f.size.height - imagePicker.navigationBar.bounds.size.height))
//        let barHeight = (f.size.height - f.size.width) / 2
//        UIGraphicsBeginImageContext(f.size)
//        UIColor(white: 0, alpha: 5).set()
//        UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal)
//        UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal)
//        let overlayImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        let overlayIV = UIImageView(frame: f)
//        overlayIV.image = overlayImage
//        imagePicker.cameraOverlayView!.addSubview(overlayIV)
        
        println(imagePicker.cameraViewTransform.a)
        println(imagePicker.cameraViewTransform.b)
        println(imagePicker.cameraViewTransform.c)
        println(imagePicker.cameraViewTransform.d)
        println(imagePicker.cameraViewTransform.tx)
        println(imagePicker.cameraViewTransform.ty)
        
        
        let transform: CGAffineTransform = CGAffineTransformMakeScale(2.0, 2.0)
        imagePicker.cameraViewTransform = transform;
        
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
        
        
        var resizedImage = takenImage
        
        var newDimension = takenImage.size.height/2
        var widthOffset = (takenImage.size.width - newDimension)/2
        var heightOffset = (takenImage.size.height - newDimension)/2
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newDimension, height: newDimension), false, 0)
        resizedImage.drawAtPoint(CGPointMake(-widthOffset, -heightOffset), blendMode:kCGBlendModeCopy , alpha: 1)
        resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        let pictureSettingsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PictureSettingsViewController") as! PictureSettingsViewController
        
        //Switch to pictureSettingView
        presentViewController(pictureSettingsViewController, animated: true) { () -> Void in
            pictureSettingsViewController.loadPicture(resizedImage)
        }
    }
    
    func beginSession() {
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }

}

