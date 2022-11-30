#import <UIKit/UIKit.h>


typedef void (^ZDYPickerViewBlock)(NSDictionary * startDic,NSDictionary *endDic);

@interface xxzLoginSettingView : UIView
@property (nonatomic , strong) NSArray *LeftArray;
@property (nonatomic , strong) NSArray *RightArray;

- (void)show;

@property (nonatomic , copy) ZDYPickerViewBlock Block;


@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;


@property (nonatomic , strong) NSString *channelId;

@end
