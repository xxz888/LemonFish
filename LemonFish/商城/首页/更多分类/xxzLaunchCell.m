
#import "xxzLaunchCell.h"

@implementation xxzLaunchCell


- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self.top_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60 ));
        make.centerX.equalTo(self.contentView);
        make.top.offset(10);
    }];
    [self.title_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.equalTo(self.top_image.mas_bottom).offset(5);
    }];
    
}

@end
