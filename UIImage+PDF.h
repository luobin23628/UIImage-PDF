//
//  UIImage+PDF.h
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

@interface UIImage (PDF)

+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName;
+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName size:(CGSize)size;
+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName width:(CGFloat)width;
+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName height:(CGFloat)height;

@end
