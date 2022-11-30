
#import "xxzDrawFormatterCell.h"

@implementation xxzDrawFormatterCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzDrawFormatterCell";
    xxzDrawFormatterCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzDrawFormatterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
