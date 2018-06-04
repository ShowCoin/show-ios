#import <UIKit/UIKit.h>

#ifndef IBInspectable
#define IBInspectable
#endif

typedef void(^MZSelectableLabelTapHandler)(NSRange range, NSString *string);

@interface MZSelectableLabelRange : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) UIColor *color;

+ (instancetype)selectableRangeWithRange:(NSRange)range color:(UIColor *)color;
@end

@interface MZSelectableLabel : UILabel
@property (nonatomic, copy) NSMutableArray *selectableRanges;

//detected ranges in the text
@property (nonatomic, copy) NSArray *detectedSelectableRanges;

@property (nonatomic, copy) MZSelectableLabelTapHandler selectionHandler;

@property (nonatomic, assign, getter = isAutomaticForegroundColorDetectionEnabled) IBInspectable BOOL automaticForegroundColorDetectionEnabled;
@property (nonatomic, strong) IBInspectable UIColor *automaticDetectionBackgroundHighlightColor;
@property (nonatomic, strong) IBInspectable UIColor *skipColorForAutomaticDetection;

- (void)setSelectableRange:(NSRange)range;
- (void)setSelectableRange:(NSRange)range hightlightedBackgroundColor:(UIColor *)color;

- (MZSelectableLabelRange *)rangeValueAtLocation:(CGPoint)location;

@end
