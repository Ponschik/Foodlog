//
//  imageProcessing.cpp
//  Foodlog
//
//  Created by Olga Koschel on 30.06.15.
//  Copyright (c) 2015 Olga Koschel. All rights reserved.
//

#include "imageProcessing.h"
#include <iostream>
#include <fstream>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/stitching.hpp>

using namespace std;
using namespace cv;

bool try_use_gpu = false;
std::vector<Mat> imgs;
String result_name = "result.jpg";
cv::Mat takenPicture;

void printUsage();
int parseCmdArgs(int argc, char** argv);

//cv::Mat stitch (vector<Mat>& images)
//{
//    imgs = images;
//    Mat pano;
//    Stitcher stitcher = Stitcher::createDefault(try_use_gpu);
//    Stitcher::Status status = stitcher.stitch(imgs, pano);
//    
//    if (status != Stitcher::OK)
//    {
//        cout << "Can't stitch images, error code = " << int(status) << endl;
//        //return 0;
//    }
//    return pano;
//}

cv::Mat toBinary(cv::Mat image, int threshold) {
    
    cv::Mat binaryImage;
    binaryImage.create(image.rows, image.cols, CV_8UC1);
    
    for(int x = 0; x < image.cols; x++){
        for(int y = 0; y < image.rows; y++){
            Vec3b pixel = image.at<Vec3b>(y,x);
            int b = pixel[0];
            int g = pixel[1];
            int r = pixel[2];
            
            int brightness = (r + g + b) / 3;
            
            if (brightness > threshold){
                binaryImage.at<uchar>(y,x) = 255;
            } else {
                binaryImage.at<uchar>(y,x) = 0;
            }
        }
    }
    
    return binaryImage;
}

cv::Mat toBinary(cv::Mat image) {
    
    cv::Mat binaryImage;
    binaryImage.create(image.rows, image.cols, CV_8UC1);
    
    int threshold = 128;
    
    for(int x = 0; x < image.cols; x++){
        for(int y = 0; y < image.rows; y++){
            Vec3b pixel = image.at<Vec3b>(y,x);
            int b = pixel[0];
            int g = pixel[1];
            int r = pixel[2];
            
            int brightness = (r + g + b) / 3;
            
            if (brightness > threshold){
                binaryImage.at<uchar>(y,x) = 255;
            } else {
                binaryImage.at<uchar>(y,x) = 0;
            }
        }
    }
    
    return binaryImage;
}

int numOfRows (cv::Mat image) {
    return image.rows;
}

//// DEPRECATED CODE //////
/*
 the code below this line is unused.
 it is derived from the openCV 'stitched' C++ sample
 left  in here only for illustration purposes
 
 - refactor main loop as member function
 - replace user input with iOS GUI
 - replace ouput with return value to CVWrapper
 
 */



//refactored as stitch function
int deprecatedMain(int argc, char* argv[])
{
    int retval = parseCmdArgs(argc, argv);
    if (retval) return -1;
    
    Mat pano;
    Stitcher stitcher = Stitcher::createDefault(try_use_gpu);
    Stitcher::Status status = stitcher.stitch(imgs, pano);
    
    if (status != Stitcher::OK)
    {
        cout << "Can't stitch images, error code = " << int(status) << endl;
        return -1;
    }
    
    imwrite(result_name, pano);
    return 0;
}

//unused
void printUsage()
{
    cout <<
    "Rotation model images stitcher.\n\n"
    "stitching img1 img2 [...imgN]\n\n"
    "Flags:\n"
    "  --try_use_gpu (yes|no)\n"
    "      Try to use GPU. The default value is 'no'. All default values\n"
    "      are for CPU mode.\n"
    "  --output <result_img>\n"
    "      The default is 'result.jpg'.\n";
}

//all input passed in via CVWrapper to stitcher function
int parseCmdArgs(int argc, char** argv)
{
    if (argc == 1)
    {
        printUsage();
        return -1;
    }
    for (int i = 1; i < argc; ++i)
    {
        if (string(argv[i]) == "--help" || string(argv[i]) == "/?")
        {
            printUsage();
            return -1;
        }
        else if (string(argv[i]) == "--try_use_gpu")
        {
            if (string(argv[i + 1]) == "no")
                try_use_gpu = false;
            else if (string(argv[i + 1]) == "yes")
                try_use_gpu = true;
            else
            {
                cout << "Bad --try_use_gpu flag value\n";
                return -1;
            }
            i++;
        }
        else if (string(argv[i]) == "--output")
        {
            result_name = argv[i + 1];
            i++;
        }
        else
        {
            Mat img = imread(argv[i]);
            if (img.empty())
            {
                cout << "Can't read image '" << argv[i] << "'\n";
                return -1;
            }
            imgs.push_back(img);
        }
    }
    return 0;
}