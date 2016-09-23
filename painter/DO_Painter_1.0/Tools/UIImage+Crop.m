//
//  UIImage+Crop.m
//  DO_Painter_1.0
//
//  Created by aDou on 16/7/9.
//  Copyright © 2016年 dou. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage(Crop)
- (UIImage*)cropImageWithPath:(NSArray*)pointArr
{
    if (pointArr.count == 0) {
        return nil;
    }
    
    CGPoint *points = malloc(sizeof(CGPoint) * pointArr.count);
    for (int i = 0; i < pointArr.count; ++i) {
        points[i] = [[pointArr objectAtIndex:i] CGPointValue];
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * self.scale, self.size.height * self.scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextAddLines(context, points, pointArr.count);
    CGContextClosePath(context);
    CGRect boundsRect = CGContextGetPathBoundingBox(context);
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(boundsRect.size);
    context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, boundsRect.size.width, boundsRect.size.height));
    
    CGMutablePathRef  path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-boundsRect.origin.x, -boundsRect.origin.y);
    CGPathAddLines(path, &transform, points, pointArr.count);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    [self drawInRect:CGRectMake(-boundsRect.origin.x, -boundsRect.origin.y, self.size.width * self.scale, self.size.height * self.scale)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGPathRelease(path);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
