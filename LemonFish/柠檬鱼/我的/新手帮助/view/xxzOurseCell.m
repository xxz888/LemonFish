
#import "xxzOurseCell.h"

@implementation xxzOurseCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (IBAction)arrowBtnAction:(id)sender {
        
       

        self.arrowBtn.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        CGAffineTransform transform = self.arrowBtn.transform;
       
       transform = CGAffineTransformScale(transform, 1,1);
        self.arrowBtn.transform = transform;
       [UIView commitAnimations];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}
@end
