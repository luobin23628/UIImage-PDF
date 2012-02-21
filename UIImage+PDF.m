//
//  UIImage+PDF.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "UIImage+PDF.h"
#import "PDFView.h"

@implementation  UIImage (PDF)

+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName {
	PDFView *pdfView = [PDFView new];
	pdfView.resourceName = resourceName;	
	pdfView.frame = (CGRect){ CGPointZero, pdfView.mediaRect.size };
    return pdfView.image;
}

+(UIImage *)imageWithPDFNamed:(NSString *)resourceName size:(CGSize)size {
	PDFView *pdfView = [PDFView new];
	pdfView.resourceName = resourceName;
	pdfView.frame = (CGRect){ CGPointZero, size };
    return pdfView.image;
}

+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName width:(CGFloat)width {
	PDFView *pdfView = [PDFView new];
	pdfView.resourceName = resourceName;
	
    CGRect mediaRect = pdfView.mediaRect;
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
	pdfView.frame = CGRectMake(0, 0, width, ceilf( width / aspectRatio ));
    
    return pdfView.image;
}

+ (UIImage *)imageWithPDFNamed:(NSString *)resourceName height:(CGFloat)height {
	PDFView *pdfView = [PDFView new];
	pdfView.resourceName = resourceName;
	
    CGRect mediaRect = pdfView.mediaRect;
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
	pdfView.frame = CGRectMake(0, 0, ceilf( height * aspectRatio ), height);
    
    return pdfView.image;
}

@end
