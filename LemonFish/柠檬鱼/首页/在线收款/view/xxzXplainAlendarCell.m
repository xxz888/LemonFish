
#import "xxzXplainAlendarCell.h"
@interface xxzXplainAlendarCell()

@end


@implementation xxzXplainAlendarCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *o_height = @"xxzXplainAlendarCell";
    xxzXplainAlendarCell *yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    if (!yitixianCell) {
        [tableView registerNib:[UINib nibWithNibName:@"xxzXplainAlendarCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:o_height];
        yitixianCell = [tableView dequeueReusableCellWithIdentifier:o_height];
    }
    yitixianCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yitixianCell;
}

@end
