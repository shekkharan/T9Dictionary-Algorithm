//
//  KeyPadCell.h
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellItem.h"

@interface KeyPadCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblAlphabets;

- (void)setData:(CellItem *)cellItem;
+ (KeyPadCell *)loadKeyPadCell;

@end
