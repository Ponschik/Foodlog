//
//  UIImage+CVMat.h
//  Foodlog
//
//  Created by Olga Koschel on 29.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>

@interface UIImage (CVMat)

//cv::Mat to UIImage
+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat;
- (id)initWithCVMat:(const cv::Mat&)cvMat;

//UIImage to cv::Mat
- (cv::Mat)CVMat;
- (cv::Mat)CVMat3;  // no alpha channel
- (cv::Mat)CVGrayscaleMat;

@end
