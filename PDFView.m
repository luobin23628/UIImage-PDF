//
//  PDFView.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "PDFView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PDFView {
	CGPDFDocumentRef document;
}

@synthesize resourceName;

- (id)init {
	if ((self = [super init])) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeScaleAspectFit;
		[self addObserver:self forKeyPath:@"resourceName" options:NSKeyValueObservingOptionNew context:NULL];
	}
	return self;
}

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"resourceName"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"resourceName"]) {
		if (document) {
			CGPDFDocumentRelease(document);
			document = NULL;
		}
		NSString *name = self.resourceName;
		if ([name hasSuffix:@"pdf"])
			name = [name substringToIndex:[name rangeOfString:@".pdf"].location];
		NSURL *URL = [[NSBundle mainBundle] URLForResource:name withExtension:@"pdf"];
        document = CGPDFDocumentCreateWithURL((__bridge CFURLRef)URL);
		return;
	}
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (CGRect)mediaRect {
	CGRect rect = CGRectZero;
    
    if (document) {
		CGPDFPageRef page1 = CGPDFDocumentGetPage( document, 1 );
		rect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );
	}
    
    return rect;
}

- (void)drawRect:(CGRect)rect  {
	if (!document)
		return;

	// Reference: http://www.cocoanetics.com/2010/06/rendering-pdf-is-easier-than-you-thought/
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor( ctx, self.backgroundColor.CGColor );
	CGContextFillRect( ctx, rect );
	
	CGContextGetCTM( ctx );
	CGContextScaleCTM( ctx, 1, -1 );
	CGContextTranslateCTM( ctx, 0, -self.bounds.size.height );
	
	CGPDFPageRef page1 = CGPDFDocumentGetPage( document, 1 );
	
	CGRect mediaRect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );
	CGContextScaleCTM( ctx, rect.size.width / mediaRect.size.width, rect.size.height / mediaRect.size.height );
	CGContextTranslateCTM( ctx, -mediaRect.origin.x, -mediaRect.origin.y );
	
	CGContextDrawPDFPage( ctx, page1 );
}

- (UIImage *)image {
	if([self.layer respondsToSelector:@selector(setShouldRasterize:)])
		UIGraphicsBeginImageContextWithOptions( self.bounds.size, NO, [UIScreen mainScreen].scale );
	else
		UIGraphicsBeginImageContext( self.bounds.size );
	
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

@end