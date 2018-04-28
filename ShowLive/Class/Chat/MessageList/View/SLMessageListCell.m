//
//  SLMessageListCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLMessageListCell.h"

@implementation SLMessageListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    // 头像
    _headPortrait=[[SLHeadPortrait alloc]initWithFrame:CGRectMake(15,15,45,45)];
    _headPortrait.delegate = self;
    //    [_headPortrait addDefaultShadow];
    [self.contentView addSubview:_headPortrait];
    
    //昵称
    _nickNameLabel = [UILabel labelWithFrame:CGRectMake(70, 18, kMainScreenWidth-100, 20) text:@"" textColor:kthemeBlackColor font:[UIFont boldSystemFontOfSize:15] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    _nickNameLabel.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    [_nickNameLabel setNumberOfLines:0];
    _nickNameLabel.opaque = YES;
    [self.contentView addSubview:_nickNameLabel];
    
    //消息内容
    _contentLabel = [UILabel labelWithFrame:CGRectMake(70, _nickNameLabel.bottom+3, kMainScreenWidth-120, 18) text:@"" textColor:RGBCOLOR(156, 158, 171) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    _contentLabel.opaque = YES;
    [self.contentView addSubview:_contentLabel];
    
    //消息时间
    _timeLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth-110, 18, 100, 16) text:@"" textColor:RGBCOLOR(156, 158, 171) font:[UIFont systemFontOfSize:11] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    _timeLabel.opaque = YES;
    [self.contentView addSubview:_timeLabel];
    
    _unreadLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth-40, 40, 18, 18) text:@"" textColor:[UIColor whiteColor] font:Font_Regular(10) backgroundColor:RGBCOLOR(156, 158, 171) alignment:NSTextAlignmentCenter];
    _unreadLabel.layer.masksToBounds = YES;
    _unreadLabel.layer.cornerRadius = 9;
    _unreadLabel.opaque = YES;
    [self.contentView addSubview:_unreadLabel];
    
    //分隔线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = kSeparationColor;
    _lineView.frame = CGRectMake(0, 74.5, kMainScreenWidth, 0.5);
    [self.contentView addSubview:_lineView];
    
    
    UILongPressGestureRecognizer* gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    gesture.minimumPressDuration=0.8;
    [self.contentView addGestureRecognizer:gesture];
}

-(void)updateViewWith:(RCConversation  *)cellData
{
    
    NSString *msgObject = cellData.objectName;
    NSString *cellText = ValidStr(msgObject) ? @"[收到新消息，请升级最新版本查看]" : @"";
    NSRange range = NSMakeRange(0, 0);
    
    if ([msgObject isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *textMsg = (RCTextMessage *)cellData.lastestMessage;
        NSString *msgText =  textMsg.content;
        if (textMsg.extra.length > 0) {
            
        }
        cellText = msgText;
    }else if([msgObject isEqualToString:RCVoiceMessageTypeIdentifier]){
        cellText = @"[语音]";
        if (cellData.unreadMessageCount > 0) {
            range = [cellText rangeOfString:@"[语音]"];
        }
    }else if([msgObject isEqualToString:RCRichContentMessageTypeIdentifier]){
        
        cellText =  @"[图片]";
        
//    } else if([msgObject isEqualToString:SLLocalGiftIdentifier]){
//        cellText = cellData.lastestMessageDirection == MessageDirection_SEND ? @"[你送出一个礼物]" : @"[你收到一个礼物]";
//        if (cellData.unreadMessageCount > 0) {
//            range = [cellText rangeOfString:cellText];
//        }
    }else if ([msgObject isEqualToString:RCRecallNotificationMessageIdentifier]){
        if (MessageDirection_SEND == cellData.lastestMessageDirection) {
            cellText = @"[你撤回了一条消息]";
        }else{
            cellText = @"[对方撤回了一条消息]";
        }
    }else if([msgObject isEqualToString:RCLocationMessageTypeIdentifier]){
        cellText = @"[位置]";
    }
    
    NSString *draft = cellData.draft;
    if (draft.length >0) {
        cellText = [NSString stringWithFormat:@"[草稿] %@",draft];
        range = [cellText rangeOfString:@"[草稿]"];
    }
    
    [_headPortrait setRoundStyle:YES imageUrl:@"" imageHeight:45  vip:NO attestation:NO];
    [_headPortrait.imageView setImage:[UIImage imageNamed:@"tag_avatar"]];
    self.nickNameLabel.textColor = kthemeBlackColor;
    self.nickNameLabel.text = @"用户昵称";
    
    self.backgroundColor = cellData.isTop ? Color(@"FBFBFB") : [UIColor whiteColor];
    
    self.unreadCount = cellData.unreadMessageCount;
    self.msgTime = cellData.sentTime;
    if(  cellData.receivedStatus == ReceivedStatus_UNREAD && self.unreadCount  == 0){
        self.unreadLabel.text = @"";
        self.unreadLabel.frame = (CGRect){kScreenWidth - 7 - 21, CGRectGetMaxY(self.timeLabel.frame) + 8,7,7};
        self.unreadLabel.layer.cornerRadius = 3.5;
        self.unreadLabel.clipsToBounds = YES;
        self.unreadLabel.hidden = NO;
    }else{
        self.unreadLabel.frame = (CGRect){kScreenWidth - 15 - 18, CGRectGetMaxY(self.timeLabel.frame) + 5,18,18};
        self.unreadLabel.layer.cornerRadius = 9;
        self.unreadLabel.clipsToBounds = YES;
    }
    
#if SLMessageList_Show_Online_Status
    NSString *contentText = cellText;
    // 在线隐身状态
    if (_cellData.onlineStatusNumber && _cellData.isVipHide == 0) {
        switch (_cellData.onlineStatusNumber.integerValue) {
            case SLRCConversationOnlineStatusOnline:
            {
                self.headPortrait.alpha = 1;
                break;
            }
            case SLRCConversationOnlineStatusOffline:
            {
                self.headPortrait.alpha = 0.5;
                break;
            }
            case SLRCConversationOnlineStatusLogout:
            {
                contentText = [NSString stringWithFormat:@"[离线]%@", cellText];
                self.headPortrait.alpha = 0.5;
                break;
            }
            default:
                break;
        }
    } else {
        self.headPortrait.alpha = 0.5; // 默认离线
    }
    self.contentLabel.text = contentText;
#else
    self.contentLabel.text = cellText;
#endif
}

-(void)setCellData:(RCConversation *)cellData
{
    _cellData = cellData;
    [self updateViewWith:_cellData];
}

-(void)setUnreadCount:(NSUInteger)unreadCount{
    _unreadCount = unreadCount;
    if (_unreadCount > 0) {
        self.unreadLabel.hidden = NO;
        NSString *showText = [@(_unreadCount) stringValue];
        if (_unreadCount > 99) {
            showText = @"99+";
        }
        self.unreadLabel.hidden = NO;
        self.unreadLabel.text = showText;
    }else{
        self.unreadLabel.hidden = YES;
    }
}

-(void)setMsgTime:(NSTimeInterval)msgTime
{
    _msgTime = msgTime;
    //时间
    NSTimeInterval time = _msgTime * 0.001; //服务器返回的时间是毫秒，13位数，而ios的时间戳是10位，所以除以1000
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString * strTime=[ShowHelper chatMessageListTimeStringWithInterval:time];
    self.timeLabel.text = strTime;
}

-(void)longPressAction{
    if (_longPressBlock) {
        _longPressBlock(self);
    }
}

#pragma mark - HeadPortraitDelegate

-(void)headPortraitClickAuthor
{
    if (self.avatarTapedBlock) {
        self.avatarTapedBlock(self);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
