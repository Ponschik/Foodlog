//
//  PictureSettingsViewController.swift
//  Foodlog
//
//  Created by Olga Koschel on 30.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

import UIKit

class PictureSettingsViewController: UIViewController {

    @IBOutlet var contrastLabel: UILabel!
    @IBOutlet var brightnessLabel: UILabel!
    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var takenPicture: UIImage!
    var threshold: Int32 = 128
    var contrast: Float32 = 1
    var brightness: Int32 = 0
    
    @IBAction func contrastChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = Float32(slider.value)
        contrast = sliderValue
        
        imageView.image = CVWrapper.showAsBinary(takenPicture, withThreshold: threshold, brightness: brightness, andContrast: contrast)
    }
    @IBAction func changeContrastLabel(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = slider.value
        contrastLabel.text = "Contrast: \(Float32(sliderValue))"
    }
    @IBAction func brightnessChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = Int32(slider.value)
        brightness = sliderValue
        
        imageView.image = CVWrapper.showAsBinary(takenPicture, withThreshold: threshold, brightness: brightness, andContrast: contrast)
    }
    @IBAction func changeBrightnessLabel(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = slider.value
        brightnessLabel.text = "Brightness: \(Int(sliderValue))"
    }
    @IBAction func thresholdChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = Int32(slider.value)
        threshold = sliderValue
        
        imageView.image = CVWrapper.showAsBinary(takenPicture, withThreshold: threshold, brightness: brightness, andContrast: contrast)
//        imageView.image = CVWrapper.showAsBinary(takenPicture)
    }
    
    @IBAction func changeThresholdLabel(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = slider.value
        thresholdLabel.text = "Threshold: \(Int(sliderValue))"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPicture(image: UIImage){
        takenPicture = image
        let binaryImage = CVWrapper.showAsBinary(takenPicture, withThreshold: threshold, brightness: brightness, andContrast: contrast)
        imageView.image = binaryImage as UIImage
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
