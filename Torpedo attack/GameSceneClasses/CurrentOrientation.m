//
//  CurrentOrientation.m
//  Torpedo attack
//
//  Created by Sergey Silak on 07.05.2021.
//

#import "CurrentOrientation.h"
#import "Constants.h"

@implementation CurrentOrientation


#pragma mark Текущая ориентация экрана
-(NSString *)getOrientation{
    NSString *orientation=PORTRAIT;
    UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];


    switch(interfaceOrientation)
    {
        case UIDeviceOrientationPortrait:
            orientation=PORTRAIT;
        break;

        case UIDeviceOrientationLandscapeLeft:
            orientation=LANDSCAPE;
        break;
        
        case UIDeviceOrientationLandscapeRight:
            orientation=LANDSCAPE;
        break;
            
        default:
        break;
    };
    
    return orientation;
}

@end
