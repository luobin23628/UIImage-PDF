//
//  PDFView.h
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

@interface PDFView : UIView

@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, readonly) CGRect mediaRect;
@property (nonatomic, readonly) UIImage *image;
  
@end
