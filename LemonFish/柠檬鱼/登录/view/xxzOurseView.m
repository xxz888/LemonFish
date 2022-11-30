
#import "xxzOurseView.h"
#import "xxzSettingController.h"
#import "xxzRticleRticlesController.h"
#import "xxzUppotController.h"
@implementation xxzOurseView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzOurseView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (IBAction)regAction:(id)sender {
    xxzUppotController * scriptController = [[xxzUppotController alloc]init];
    scriptController.come = @"000";
    [self.viewController presentViewController:scriptController animated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    
    if (self.loginBlock) {
        self.loginBlock(self.phoneTf.text, [NSString stringWithFormat:@"%@",self.passTf.text]);
    }
}

- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

    __weak typeof(self) weakSelf = self;
    [self.xieyiBtn bk_whenTapped:^{
        [weakSelf.viewController presentViewController:[xxzRticleRticlesController new] animated:YES completion:nil];
    }];
}
@end
