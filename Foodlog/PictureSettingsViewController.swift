//
//  PictureSettingsViewController.swift
//  Foodlog
//
//  Created by Olga Koschel on 30.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

import UIKit

class PictureSettingsViewController: UIViewController {

    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var takenPicture: UIImage!
    
    @IBAction func thresholdChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        let sliderValue = Int32(slider.value)
        println(sliderValue)
        imageView.image = CVWrapper.showAsBinary(takenPicture, withThreshold: sliderValue)
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
        let binaryImage = CVWrapper.showAsBinary(takenPicture, withThreshold: 128)
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
