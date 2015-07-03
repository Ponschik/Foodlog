//
//  CVWrapper.m
//  Foodlog
//
//  Created by Olga Koschel on 29.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

#import "CVWrapper.h"
#import "UIImage+CVMat.h"
#import "imageProcessing.h"

@implementation CVWrapper

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage
{
    NSArray* imageArray = [NSArray arrayWithObject:inputImage];
    UIImage* result = [[self class] processWithArray:imageArray];
    return result;
}

+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;
{
    NSArray* imageArray = [NSArray arrayWithObjects:inputImage1,inputImage2,nil];
    UIImage* result = [[self class] processWithArray:imageArray];
    return result;
}

//+ (UIImage*) processWithArray:(NSArray*)imageArray
//{
//    if ([imageArray count]==0){
//        NSLog (@"imageArray is empty");
//        return 0;
//    }
//    
//    std::vector<cv::Mat> matImages;
//    
//    for (id image in imageArray) {
//        if ([image isKindOfClass: [UIImage class]]) {
//            cv::Mat matImage = [image CVMat3];
//            NSLog (@"matImage: %@",image);
//            matImages.push_back(matImage);
//        }
//    }
//    
//    NSLog (@"stitching...");
//    cv::Mat stitchedMat = stitch(matImages);
//    UIImage* result =  [UIImage imageWithCVMat:stitchedMat];
//    return result;
//}

+ (UIImage *)showAsBinary:(UIImage *)inputImage withThreshold:(int32_t)threshold brightness:(int32_t)brightness andContrast:(Float32)contrast{
    
    cv::Mat binaryMat = toBinary(inputImage.CVMat3, threshold, brightness, contrast);
    UIImage* result = [UIImage imageWithCVMat:binaryMat];
    return result;
}

+ (UIImage *)showAsBinary:(UIImage *)inputImage withThreshold:(int)threshold{
    
    
    cv::Mat binaryMat = toBinary(inputImage.CVMat3, (int)threshold);
    UIImage* result = [UIImage imageWithCVMat:binaryMat];
    
    return result;
}

+(UIImage *)showAsBinary:(UIImage *)inputImage {
    cv::Mat binaryMat = toBinary(inputImage.CVMat3);
    UIImage* result = [UIImage imageWithCVMat:binaryMat];
    
    return result;
}

+(int)numberOfRows:(UIImage *)inputImage {
    
    cv::Mat matImage = [inputImage CVMat3];
    
    return numOfRows(matImage);
}

@end
