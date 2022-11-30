
#import <UIKit/UIKit.h>

@class xxzHuxukaView;

@protocol VWxxzEdit <NSObject>

@optional

- (void)segmentTitleView:(xxzHuxukaView *)segmentView
           selectedIndex:(NSInteger)selectedIndex
       lastSelectedIndex:(NSInteger)lastSelectedIndex;

@end

@protocol VWxxzPicker <NSObject>

@optional

- (NSArray *)segmentTitlesOfSegmentTitleView:(xxzHuxukaView *)segmentView;

@end

@interface xxzHuxukaView : UIView

- (void)reloadData;

@property (nonatomic, weak) id<VWxxzEdit> delegate;

@property (nonatomic, weak) id<VWxxzPicker> dataSource;


@property (nonatomic, strong) UIColor *titleNormalColor;


@property (nonatomic, strong) UIColor *titleSelectedColor;



@property (nonatomic, assign) NSInteger selectedIndex;



@property (nonatomic, strong) UIFont *titleFont;



@property (nonatomic, strong) UIColor *indicatorColor;


@property (nonatomic, assign) CGFloat indicatorHeight;



@property (nonatomic, assign) CGFloat indicatorExtraW;



@property (nonatomic, assign) CGFloat indicatorBottomMargin;


@property (nonatomic, assign) CGFloat itemMinMargin;


@property (nonatomic, copy) NSArray<NSString *> *segmentTitles;

@end
