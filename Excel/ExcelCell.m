//
//  ExcelCell.m
//  Excel
//
//  Created by nbcb on 2017/10/26.
//  Copyright © 2017年 ZQC. All rights reserved.
//

#import "ExcelCell.h"
#import "Masonry.h"

@interface ExcelCell ()

@end

@implementation ExcelCell

- (UILabel *)label {
    
    if (!_label) {
        
        self.label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:13.f];
        _label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.offset(5);
            make.bottom.offset(-5);
            make.right.offset(-5);
        }];
        
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentView.layer.borderWidth = 0.5;
    }
    return _label;
}

@end
