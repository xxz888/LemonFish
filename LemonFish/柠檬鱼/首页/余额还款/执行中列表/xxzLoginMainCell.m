
#import "xxzLoginMainCell.h"
@interface xxzLoginMainCell()

@end


@implementation xxzLoginMainCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzLoginMainCell";
    xxzLoginMainCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzLoginMainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (void)awakeFromNib {
    [super awakeFromNib];

    
    
}

@end
