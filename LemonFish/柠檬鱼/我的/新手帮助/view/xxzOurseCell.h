
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzOurseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UIView *cellDiv;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
- (IBAction)arrowBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end

NS_ASSUME_NONNULL_END
