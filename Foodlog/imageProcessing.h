//
//  imageProcessing.h
//  Foodlog
//
//  Created by Olga Koschel on 30.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

#ifndef CVOpenTemplate_Header_h
#define CVOpenTemplate_Header_h
#include <opencv2/opencv.hpp>

cv::Mat stitch (std::vector <cv::Mat> & images);
int numOfRows (cv::Mat image);
cv::Mat toBinary(cv::Mat image, int threshold);
cv::Mat toBinary(cv::Mat image);

#endif
