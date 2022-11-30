
#import "xxzHangeRateCell.h"
#import "xxzArner.h"
#import "xxzInstitution.h"
#import "xxzOginEmptyController.h"
@interface xxzHangeRateCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UIImageView *imgV4;
@property (weak, nonatomic) IBOutlet UIImageView *imgV5;
@property (weak, nonatomic) IBOutlet UIImageView *imgV6;
@property (weak, nonatomic) IBOutlet UIImageView *imgV7;
@property (weak, nonatomic) IBOutlet UIImageView *imgV8;
@property (weak, nonatomic) IBOutlet UIImageView *imgV9;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHW4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHW7;

@property(nonatomic, strong) NSDictionary * display;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property(nonatomic, strong) xxzInstitution *yitixian;
#define MCSCALE SCREEN_WIDTH/375

@end

@implementation xxzHangeRateCell
- (IBAction)shareAction:(id)sender {
    xxzOginEmptyController * vc = [[xxzOginEmptyController alloc]init];
    vc.currentId  = [NSString stringWithFormat:@"%@",_display[@"id"]];
    [self.viewController.xp_rootNavigationController pushViewController:vc animated:YES];

}

- (xxzInstitution *)yitixian {
    if (!_yitixian) {
        _yitixian = [[xxzInstitution alloc] initWithFrame:CGRectMake(0, 0, 192, 40)];
        _yitixian.automaticallyHidesWhenUserTap = YES;
        _yitixian.preferLayoutDirection = QMUIPopupContainerViewLayoutDirectionLeft;
        _yitixian.sourceView  = self.moreBtn;
        __weak __typeof(self)weakSelf = self;
        _yitixian.selectedBlock = ^(NSInteger index) {
            if (index == 1) {
                [weakSelf saveAction];
            } else {
                [weakSelf cpAction];
            }
        };
    }
    return _yitixian;
}
+ (instancetype)cellWithTableview:(UITableView *)tableview articleModel:(NSDictionary *)display {
    static NSString *shop = @"xxzHangeRateCell";
    xxzHangeRateCell *yitixianCell = [tableview dequeueReusableCellWithIdentifier:shop];
    
    if (!yitixianCell) {
        [tableview registerNib:[UINib nibWithNibName:shop bundle:nil] forCellReuseIdentifier:shop];
        yitixianCell = [tableview dequeueReusableCellWithIdentifier:shop];
    }
    yitixianCell.display = display;
    
    return yitixianCell;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imgHW.constant = 104*SCREEN_WIDTH/375;
 

    UITapGestureRecognizer *debit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *week = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *shouru = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *abbar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *addf = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *adress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *zhidingjihua = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *stroke = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    UITapGestureRecognizer *huankuan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];

    [self.imgV1 addGestureRecognizer:debit];
    [self.imgV2 addGestureRecognizer:week];
    [self.imgV3 addGestureRecognizer:shouru];
    [self.imgV4 addGestureRecognizer:abbar];
    [self.imgV5 addGestureRecognizer:addf];
    [self.imgV6 addGestureRecognizer:adress];
    [self.imgV7 addGestureRecognizer:zhidingjihua];
    [self.imgV8 addGestureRecognizer:stroke];
    [self.imgV9 addGestureRecognizer:huankuan];

    self.imgV1.layer.cornerRadius = 5;
    self.imgV2.layer.cornerRadius = 5;
    self.imgV3.layer.cornerRadius = 5;
    self.imgV4.layer.cornerRadius = 5;
    self.imgV5.layer.cornerRadius = 5;
    self.imgV6.layer.cornerRadius = 5;
    self.imgV7.layer.cornerRadius = 5;
    self.imgV8.layer.cornerRadius = 5;
    self.imgV9.layer.cornerRadius = 5;

}
- (void)imgTap:(UITapGestureRecognizer *)tap {
    UIImageView *goodsView = (UIImageView *)tap.view;
    if (goodsView && goodsView.image) {
        [xxzArner scanBigImageWithImageView:goodsView alpha:1];
    }
}

- (void)setDisplay:(NSDictionary *)display{
    _display = display;
 
    self.dayLab.text =display[@"createTime"];
    [self.shareBtn setTitle:[NSString stringWithFormat:@" %@",display[@"shareCount"]] forState:0];
    self.contentLab.text = display[@"content"];
    
    
    if ([display[@"children"] count] == 9) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        self.imgV6.hidden = NO;
        self.imgV7.hidden = NO;
        self.imgV8.hidden = NO;
        self.imgV9.hidden = NO;
       
        
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
            
            
            NSData *has = [[NSData alloc]initWithBase64EncodedString:display[@"children"][5][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *iconU = [UIImage imageWithData:has];
            self.imgV6.image  = iconU;
            
            
            NSData *stringh = [[NSData alloc]initWithBase64EncodedString:display[@"children"][6][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *guiguang = [UIImage imageWithData:stringh];
            self.imgV7.image  = guiguang;
            
            
            NSData *oney = [[NSData alloc]initWithBase64EncodedString:display[@"children"][7][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *card = [UIImage imageWithData:oney];
            self.imgV8.image  = card;
            
            
            NSData *days = [[NSData alloc]initWithBase64EncodedString:display[@"children"][8][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *add = [UIImage imageWithData:down];
            self.imgV9.image  = add;
            
            
            
     
       

        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = NO;
        
    }else if ([display[@"children"] count] == 8) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        self.imgV6.hidden = NO;
        self.imgV7.hidden = NO;
        self.imgV8.hidden = NO;
        self.imgV9.hidden = NO;
        [self.imgV9 sd_setImageWithURL:@"" placeholderImage:nil];
        self.imgV9.userInteractionEnabled = NO;
        
        
 
            
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
            
            
            NSData *has = [[NSData alloc]initWithBase64EncodedString:display[@"children"][5][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *iconU = [UIImage imageWithData:has];
            self.imgV6.image  = iconU;
            
            
            NSData *stringh = [[NSData alloc]initWithBase64EncodedString:display[@"children"][6][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *guiguang = [UIImage imageWithData:stringh];
            self.imgV7.image  = guiguang;
            
            
            NSData *oney = [[NSData alloc]initWithBase64EncodedString:display[@"children"][7][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *card = [UIImage imageWithData:oney];
            self.imgV8.image  = card;
   

        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = NO;
        
    }else if ([display[@"children"] count] == 7) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        self.imgV6.hidden = NO;
        self.imgV7.hidden = NO;
        self.imgV8.hidden = NO;
        [self.imgV8 sd_setImageWithURL:@"" placeholderImage:nil];
        self.imgV8.userInteractionEnabled = NO;
        self.imgV9.hidden = NO;
        [self.imgV9 sd_setImageWithURL:@"" placeholderImage:nil];
        self.imgV9.userInteractionEnabled = NO;
        
        
 
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
            
            
            NSData *has = [[NSData alloc]initWithBase64EncodedString:display[@"children"][5][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *iconU = [UIImage imageWithData:has];
            self.imgV6.image  = iconU;
            
            
            NSData *stringh = [[NSData alloc]initWithBase64EncodedString:display[@"children"][6][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *guiguang = [UIImage imageWithData:stringh];
            self.imgV7.image  = guiguang;
    
    

        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = NO;
        
    }else if ([display[@"children"] count] == 6) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        self.imgV6.hidden = NO;
      
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;

        
    
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
            
            
            NSData *has = [[NSData alloc]initWithBase64EncodedString:display[@"children"][5][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *iconU = [UIImage imageWithData:has];
            self.imgV6.image  = iconU;
 
  

        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = YES;
        
    }else if ([display[@"children"] count] == 5) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        
        self.imgV6.hidden = NO;
        [self.imgV6 sd_setImageWithURL:@"" placeholderImage:nil];
        self.imgV6.userInteractionEnabled = NO;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;

        
   
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
     
      
        
        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = YES;
        
    }else if ([display[@"children"] count] == 4) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = YES;
        self.imgV4.hidden = NO;
        self.imgV5.hidden = NO;
        
        self.imgV6.hidden = YES;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;

    
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            
            NSData *cut = [[NSData alloc]initWithBase64EncodedString:display[@"children"][3][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chuxuka = [UIImage imageWithData:cut];
            self.imgV4.image  = chuxuka;
            
            
            NSData *icon = [[NSData alloc]initWithBase64EncodedString:display[@"children"][4][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *location = [UIImage imageWithData:icon];
            self.imgV5.image  = location;
 

        
        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = NO;
        self.imgV7.superview.hidden = YES;
        
    } else if ([display[@"children"] count] == 3) {
        self.imgHW.constant = 104*MCSCALE;
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = NO;
        self.imgV4.hidden = YES;
        
        self.imgV5.hidden = YES;
        self.imgV6.hidden = YES;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;
        
  
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
            
            
            NSData *rate = [[NSData alloc]initWithBase64EncodedString:display[@"children"][2][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *current = [UIImage imageWithData:rate];
            self.imgV3.image  = current;
      

        
        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = YES;
        self.imgV7.superview.hidden = YES;

    } else if ([display[@"children"] count] == 2) {
        self.imgHW.constant = 104*MCSCALE;
        
        self.imgV1.hidden = NO;
        self.imgV2.hidden = NO;
        self.imgV3.hidden = YES;
        self.imgV4.hidden = YES;
        self.imgV5.hidden = YES;
        self.imgV6.hidden = YES;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;
        
        
            
            NSData *down = [[NSData alloc]initWithBase64EncodedString:display[@"children"][0][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *tip = [UIImage imageWithData:down];
            self.imgV1.image  = tip;
            
            
            NSData *reg = [[NSData alloc]initWithBase64EncodedString:display[@"children"][1][@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *magey = [UIImage imageWithData:reg];
            self.imgV2.image  = magey;
    

        
        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = YES;
        self.imgV7.superview.hidden = YES;

    } else if ([display[@"children"] count] == 1) {
        self.imgHW.constant = 104 * MCSCALE;
        self.imgV1.hidden = NO;
        
        self.imgV2.hidden = YES;
        self.imgV3.hidden = YES;
        self.imgV4.hidden = YES;
        self.imgV5.hidden = YES;
        self.imgV6.hidden = YES;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;
        
      
  
        [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:display[@"children"][0][@"content"]] placeholderImage:[UIImage imageNamed:@"empowerYangkajigou"]];;

        
        self.imgV1.superview.hidden = NO;
        self.imgV4.superview.hidden = YES;
        self.imgV7.superview.hidden = YES;

    } else {
        self.imgV1.hidden = YES;
        self.imgV2.hidden = YES;
        self.imgV3.hidden = YES;
        self.imgV4.hidden = YES;
        
        self.imgV5.hidden = YES;
        self.imgV6.hidden = YES;
        self.imgV7.hidden = YES;
        self.imgV8.hidden = YES;
        self.imgV9.hidden = YES;
        
        self.imgV1.superview.hidden = YES;
        self.imgV3.superview.hidden = YES;
        self.imgV7.superview.hidden = YES;

    }
    
}

- (void)saveAction {
    if ([self.display[@"children"] count] == 9) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
        [self saveToAlbum:self.imgV6.image];
        [self saveToAlbum:self.imgV7.image];
        [self saveToAlbum:self.imgV8.image];
        [self saveToAlbum:self.imgV9.image];
    }else if ([self.display[@"children"] count] == 8) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
        [self saveToAlbum:self.imgV6.image];
        [self saveToAlbum:self.imgV7.image];
        [self saveToAlbum:self.imgV8.image];
    }else if ([self.display[@"children"] count] == 7) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
        [self saveToAlbum:self.imgV6.image];
        [self saveToAlbum:self.imgV7.image];
    }else if ([self.display[@"children"] count] == 6) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
        [self saveToAlbum:self.imgV6.image];
    }else if ([self.display[@"children"] count] == 5) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
    }else if ([self.display[@"children"] count] == 4) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV4.image];
        [self saveToAlbum:self.imgV5.image];
    }else if ([self.display[@"children"] count] == 3) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
        [self saveToAlbum:self.imgV3.image];
    } else if ([self.display[@"children"] count] == 2) {
        [self saveToAlbum:self.imgV1.image];
        [self saveToAlbum:self.imgV2.image];
    } else if ([self.display[@"children"] count] == 1) {
        [self saveToAlbum:self.imgV1.image];
    } else {
        
        
        [xxzBase showBottomWithText:@"暂无可保存图片"];

    }
}
- (void)cpAction {
    if (self.display[@"content"]) {
        UIPasteboard.generalPasteboard.string = self.display[@"content"];
        [xxzBase showBottomWithText:@"文案已复制到剪切板"];
    }
}
- (IBAction)saveImvAction:(id)sender {
    [self saveAction];

}

- (IBAction)fuzhiwenanAction:(id)sender {
    [self cpAction];
}


- (void)saveToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    return;
    [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"===============%@", [NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *session = @"";
            
            if (error) {
                session = @"保存失败，请重试！";
            } else {
                session = @"保存成功！";
            }
        });
    }];
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {

        [xxzBase showBottomWithText:@"保存成功"];
    }
}
- (IBAction)moreBtnTouched:(UIButton *)sender {
    [self.yitixian showWithAnimated:YES];
}

@end
