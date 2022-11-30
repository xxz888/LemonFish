
#import "xxzTradingCell.h"
@interface xxzTradingCell()

@end


@implementation xxzTradingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzTradingCell";
    xxzTradingCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzTradingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}

@end
