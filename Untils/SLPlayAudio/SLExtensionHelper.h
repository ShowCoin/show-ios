
//  Created by showgx on 4/25/16.
//  Copyright © 2016 show gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SLMKitExtension)

- (NSDictionary *)slkit_jsonDict;
@end


@interface NSDictionary (SLMKitExtension)
- (NSString *)slkit_jsonString;
@end
