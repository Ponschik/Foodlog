//
//  CVWrapper.h
//  Foodlog
//
//  Created by Olga Koschel on 29.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CVWrapper : NSObject

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage;

+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;

+ (UIImage*) processWithArray:(NSArray*)imageArray;

+ (UIImage*) showAsBinary:(UIImage*)inputImage withThreshold:(int32_t)threshold;

+ (UIImage*) showAsBinary:(UIImage*)inputImage withThreshold:(int32_t)threshold brightness:(int32_t)brightness andContrast:(Float32)contrast;

+ (UIImage*) showAsBinary:(UIImage*)inputImage;

+ (int) numberOfRows:(UIImage *)inputImage;

@end
