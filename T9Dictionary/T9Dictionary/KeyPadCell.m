//
//  KeyPadCell.m
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "KeyPadCell.h"

@implementation KeyPadCell

- (void)setNeedsDisplay
{
}

+ (KeyPadCell *)loadKeyPadCell
{
   KeyPadCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"KeyPadCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}

- (void)setData:(CellItem *)cellItem
{
    self.lblAlphabets.text = cellItem.alphabets;
    self.lblNumber.text = cellItem.number;
}

@end
