
#import "xxzHeaderCell.h"

@implementation xxzHeaderCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzHeaderCell";
    xxzHeaderCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
