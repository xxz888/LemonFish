

#define kScreenWidth               [UIScreen mainScreen].bounds.size.width
#define kScreenHeight              [UIScreen mainScreen].bounds.size.height
#define kMainWindow                [UIApplication sharedApplication].keyWindow

#define kArrowWidth          15
#define kArrowHeight         10
#define kDefaultMargin       10
#define kAnimationTime       0.25

#import "xxzHangeEmptyView.h"

@interface UIView (YCFrame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@end

@implementation UIView (YCFrame)
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint mine = self.center;
    mine.x = centerX;
    self.center = mine;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint minew = self.center;
    minew.y = centerY;
    self.center = minew;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end

@interface xxzPlanNavigationCell : UITableViewCell
@property (nonatomic,assign) BOOL         url;
@property (nonatomic,strong) UIColor    * separatorColor;
@end
@implementation xxzPlanNavigationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _url = YES;
        _separatorColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setSeparatorColor:(UIColor *)separatorColor{
    _separatorColor = separatorColor;
    [self setNeedsDisplay];
}
- (void)setUrl:(BOOL)url{
    _url = url;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    if (!_url)return;
    UIBezierPath *photo = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5)];
    [_separatorColor setFill];
    [photo fillWithBlendMode:kCGBlendModeNormal alpha:1.0f];
    [photo closePath];
}
@end


@interface xxzProgressGoods()
@property (nonatomic) NSString      *title;
@property (nonatomic) UIImage       *image;
@property (copy, nonatomic)void (^handler)(xxzProgressGoods *);
@end
@implementation xxzProgressGoods
+ (instancetype)actionWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(xxzProgressGoods *))handler{
    xxzProgressGoods *show = [[xxzProgressGoods alloc] initWithTitle:title image:image handler:handler];
    return show;
}
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(xxzProgressGoods *))handler{
    if (self = [super init]) {
        _title = title;
        _image = image;
        _handler = [handler copy];
    }
    return self;
}
@end


@interface xxzHangeEmptyView()<UITableViewDelegate,UITableViewDataSource>
{
    CGPoint          _refPoint;
    UIView          *_refView;
    CGFloat          _menuWidth;
    
    CGFloat         _arrowPosition; 
    CGFloat         _topMargin;
    BOOL            _isReverse; 
    BOOL            _needReload; 
}
@property(nonatomic,copy) NSArray<xxzProgressGoods *>   *actions;
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)UIView                   *contentView;
@property(nonatomic,strong)UIView                   *empower;

@end

static NSString *const menuCellID = @"xxzPlanNavigationCell";
@implementation xxzHangeEmptyView

+ (instancetype)menuWithActions:(NSArray<xxzProgressGoods *> *)actions width:(CGFloat)width atPoint:(CGPoint)point{
    NSAssert(width>0.0f, @"width要大于0");
    xxzHangeEmptyView *danbixiane = [[xxzHangeEmptyView alloc] initWithActions:actions width:width atPoint:point];
    return danbixiane;
}
+ (instancetype)menuWithActions:(NSArray<xxzProgressGoods *> *)actions width:(CGFloat)width relyonView:(id)view{
    NSAssert(width>0.0f, @"width要大于0");
    NSAssert([view isKindOfClass:[UIView class]]||[view isKindOfClass:[UIBarButtonItem class]], @"relyonView必须是UIView或UIBarButtonItem");
    xxzHangeEmptyView *danbixianej = [[xxzHangeEmptyView alloc] initWithActions:actions width:width relyonView:view];
    return danbixianej;
}

- (instancetype)initWithActions:(NSArray<xxzProgressGoods *> *)actions width:(CGFloat)width atPoint:(CGPoint)point{
    if (self = [super init]) {
        _actions = [actions copy];
        _refPoint = point;
        _menuWidth = width;
        [self defaultConfiguration];
        [self setupSubView];
    }
    return self;
}

- (instancetype)initWithActions:(NSArray<xxzProgressGoods *> *)actions width:(CGFloat)width relyonView:(id)view{
    if (self = [super init]) {
        
        if ([view isKindOfClass:[UIBarButtonItem class]]) {
            UIView *accView = [view valueForKey:@"_view"];
            _refView = accView;
        }else{
            _refView = view;
        }
        _actions = [actions copy];
        _menuWidth = width;
        [self defaultConfiguration];
        [self setupSubView];
    }
    return self;
}

- (void)defaultConfiguration{
    self.alpha = 0.0f;
    [self setDefaultShadow];
    
    _cornerRaius = 5.0f;
    _separatorColor = [UIColor blackColor];
    _menuColor = [UIColor whiteColor];
    _menuCellHeight = 44.0f;
    _maxDisplayCount = 5;
    _isShowShadow = YES;
    _dismissOnselected = YES;
    _dismissOnTouchOutside = YES;
    
    _textColor = [UIColor blackColor];
    _textFont = [UIFont systemFontOfSize:15.0f];
    _offset = 0.0f;
}

- (void)setupSubView{
    [self calculateArrowAndFrame];
    [self setupMaskLayer];
    [self addSubview:self.contentView];
}

- (void)reloadData{
    [self.contentView removeFromSuperview];
    [self.tableView removeFromSuperview];
    self.contentView = nil;
    self.tableView = nil;
    [self setupSubView];
}

- (CGPoint)getRefPoint{
    CGRect cvn = [_refView convertRect:_refView.bounds toView:kMainWindow];
    CGPoint header;
    if (cvn.origin.y + cvn.size.height + _actions.count * _menuCellHeight > kScreenHeight - 10) {
        header = CGPointMake(cvn.origin.x + cvn.size.width / 2, cvn.origin.y);
        _isReverse = YES;
    }else{
        header = CGPointMake(cvn.origin.x + cvn.size.width / 2, cvn.origin.y + cvn.size.height);
        _isReverse = NO;
    }
    return header;
}

- (void)show{
    
    if (_needReload) [self reloadData];
    
    [kMainWindow addSubview: self.empower];
    [kMainWindow addSubview: self];
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration: kAnimationTime animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0f;
        self.empower.alpha = 1.0f;
    }];
}

- (void)dismiss{
    if (!_dismissOnTouchOutside) return;
    [UIView animateWithDuration: kAnimationTime animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.0f;
        self.empower.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.empower removeFromSuperview];
        self.actions = nil;
    }];
}

#pragma mark - Private
- (void)setupMaskLayer{
    CAShapeLayer *sign = [self drawMaskLayer];
    self.contentView.layer.mask = sign;
}

- (void)calculateArrowAndFrame{
    if (_refView) {
        _refPoint = [self getRefPoint];
    }
    
    CGFloat zhangdanri;
    CGFloat buffer;
    CGFloat clear;
    CGFloat masks;
    
    clear = _menuWidth;
    masks = (_actions.count > _maxDisplayCount) ? _maxDisplayCount * _menuCellHeight + kArrowHeight: _actions.count * _menuCellHeight + kArrowHeight;
    
    _arrowPosition = 0.5 * clear - 0.5 * kArrowWidth;
    
    
    zhangdanri = _refPoint.x - _arrowPosition - 0.5 * kArrowWidth;
    buffer = _refPoint.y;
    
    
    if (zhangdanri + clear > kScreenWidth - 10) {
        zhangdanri = kScreenWidth - kDefaultMargin - clear;
    }else if (zhangdanri < 10) {
        
        zhangdanri = kDefaultMargin;
    }
    
    
    if ((_refPoint.x <= zhangdanri + clear - _cornerRaius) && (_refPoint.x >= zhangdanri + _cornerRaius)) {
        _arrowPosition = _refPoint.x - zhangdanri - 0.5 * kArrowWidth;
    }else if (_refPoint.x < zhangdanri + _cornerRaius) {
        _arrowPosition = _cornerRaius;
    }else {
        _arrowPosition = clear - _cornerRaius - kArrowWidth;
    }
    
    
    if (!_refView) {
        _isReverse = (buffer + masks > kScreenHeight - kDefaultMargin)?YES:NO;
    }
    
    CGPoint  btn;
    if (_isReverse) {
        buffer = _refPoint.y - masks;
        btn = CGPointMake(fabs(_arrowPosition) / clear, 1);
        _topMargin = 0;
    }else{
        btn = CGPointMake(fabs(_arrowPosition) / clear, 0);
        _topMargin = kArrowHeight;
    }
    buffer += buffer >= _refPoint.y ? _offset : -_offset;
    
    
    self.layer.anchorPoint = btn;
    self.frame = CGRectMake(zhangdanri, buffer, clear, masks);
}

- (CAShapeLayer *)drawMaskLayer{
    CAShapeLayer *foot = [CAShapeLayer layer];
    CGFloat price = !_isReverse?0 :kArrowHeight;
    
    
    CGPoint loadblock = CGPointMake(self.width - _cornerRaius, _topMargin + _cornerRaius);
    CGPoint u_player = CGPointMake(_cornerRaius, _topMargin + _cornerRaius);
    CGPoint ziyongfanxian = CGPointMake(self.width - _cornerRaius, self.height - price - _cornerRaius);
    CGPoint efresh = CGPointMake(_cornerRaius, self.height - price - _cornerRaius);
    
    UIBezierPath *photo2 = [UIBezierPath bezierPath];
    
    [photo2 moveToPoint: CGPointMake(0, _topMargin + _cornerRaius)];
    [photo2 addLineToPoint: CGPointMake(0, efresh.y)];
    [photo2 addArcWithCenter: efresh radius: _cornerRaius startAngle: -M_PI endAngle: -M_PI-M_PI_2 clockwise: NO];
    
    if (_isReverse) {
        [photo2 addLineToPoint: CGPointMake(_arrowPosition, self.height - kArrowHeight)];
        [photo2 addLineToPoint: CGPointMake(_arrowPosition + 0.5*kArrowWidth, self.height)];
        [photo2 addLineToPoint: CGPointMake(_arrowPosition + kArrowWidth, self.height - kArrowHeight)];
    }
    [photo2 addLineToPoint: CGPointMake(self.width - _cornerRaius, self.height - price)];
    [photo2 addArcWithCenter: ziyongfanxian radius: _cornerRaius startAngle: -M_PI-M_PI_2 endAngle: -M_PI*2 clockwise: NO];
    [photo2 addLineToPoint: CGPointMake(self.width, self.height - price + _cornerRaius)];
    [photo2 addArcWithCenter: loadblock radius: _cornerRaius startAngle: 0 endAngle: -M_PI_2 clockwise: NO];
    
    if (!_isReverse) {
        [photo2 addLineToPoint: CGPointMake(_arrowPosition + kArrowWidth, _topMargin)];
        [photo2 addLineToPoint: CGPointMake(_arrowPosition + 0.5 * kArrowWidth, 0)];
        [photo2 addLineToPoint: CGPointMake(_arrowPosition, _topMargin)];
    }
    
    [photo2 addLineToPoint: CGPointMake(_cornerRaius, _topMargin)];
    [photo2 addArcWithCenter: u_player radius: _cornerRaius startAngle: -M_PI_2 endAngle: -M_PI clockwise: NO];
    [photo2 closePath];
    
    foot.path = photo2.CGPath;
    return foot;
}
- (void)setDefaultShadow{
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5.0;
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _actions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzPlanNavigationCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:menuCellID forIndexPath:indexPath];
    xxzProgressGoods *showW = _actions[indexPath.row];
    yitixianCell.backgroundColor = [UIColor clearColor];
    yitixianCell.textLabel.font = _textFont;
    yitixianCell.textLabel.textColor = _textColor;
    yitixianCell.textLabel.text = showW.title;
    yitixianCell.separatorColor = _separatorColor;
    yitixianCell.imageView.image = showW.image?showW.image:nil;
    if (showW.image == nil) {
        yitixianCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (indexPath.row == _actions.count - 1) {
        yitixianCell.url = NO;
    }
    if ([self.menuSelectCell isEqualToString:showW.title]) {
        yitixianCell.contentView.backgroundColor = FontThemeColor;
    }
    return yitixianCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dismissOnselected) [self dismiss];
    xxzProgressGoods *showc = _actions[indexPath.row];
    if (showc.handler) {
        showc.handler(showc);
    }
}

#pragma mark - Setting&&Getting
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topMargin, self.width, self.height - kArrowHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = _actions.count > _maxDisplayCount? YES : NO;
        _tableView.rowHeight = _menuCellHeight;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[xxzPlanNavigationCell class] forCellReuseIdentifier:menuCellID];
    }
    return _tableView;
}
- (UIView *)empower{
    if (!_empower) {
        _empower = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _empower.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _empower.alpha = 0.0f;
        UITapGestureRecognizer *camera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_empower addGestureRecognizer:camera];
    }
    return _empower;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = _menuColor;
        _contentView.layer.masksToBounds = YES;
        [_contentView addSubview:self.tableView];
    }
    return _contentView;
}
#pragma mark - 设置属性
- (void)setCornerRaius:(CGFloat)cornerRaius{
    if (_cornerRaius == cornerRaius)return;
    _cornerRaius = cornerRaius;
    self.contentView.layer.mask = [self drawMaskLayer];
}
- (void)setMenuColor:(UIColor *)menuColor{
    if ([_menuColor isEqual:menuColor]) return;
    _menuColor = menuColor;
    self.contentView.backgroundColor = menuColor;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    if ([_menuColor isEqual:backgroundColor]) return;
    _menuColor = backgroundColor;
    self.contentView.backgroundColor = _menuColor;
}
- (void)setSeparatorColor:(UIColor *)separatorColor{
    if ([_separatorColor isEqual:separatorColor]) return;
    _separatorColor = separatorColor;
    [self.tableView reloadData];
}
- (void)setMenuCellHeight:(CGFloat)menuCellHeight{
    if (_menuCellHeight == menuCellHeight)return;
    _menuCellHeight = menuCellHeight;
    _needReload = YES;
}
- (void)setMaxDisplayCount:(NSInteger)maxDisplayCount{
    if (_maxDisplayCount == maxDisplayCount)return;
    _maxDisplayCount = maxDisplayCount;
    _needReload = YES;
}
- (void)setIsShowShadow:(BOOL)isShowShadow{
    if (_isShowShadow == isShowShadow)return;
    _isShowShadow = isShowShadow;
    if (!_isShowShadow) {
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0.0;
    }else{
        [self setDefaultShadow];
    }
}
- (void)setTextFont:(UIFont *)textFont{
    if ([_textFont isEqual:textFont]) return;
    _textFont = textFont;
    [self.tableView reloadData];
}
- (void)setTextColor:(UIColor *)textColor{
    if ([_textColor isEqual:textColor]) return;
    _textColor = textColor;
    [self.tableView reloadData];
}
- (void)setOffset:(CGFloat)offset{
    if (offset == offset) return;
    _offset = offset;
    if (offset < 0.0f) {
        offset = 0.0f;
    }
    self.y += self.y >= _refPoint.y ? offset : -offset;
}
@end
