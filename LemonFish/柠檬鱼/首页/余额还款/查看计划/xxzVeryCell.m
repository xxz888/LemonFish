
#import "xxzVeryCell.h"
@interface xxzVeryCell()

@end


@implementation xxzVeryCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzVeryCell";
    xxzVeryCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzVeryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    
    
}

@end
