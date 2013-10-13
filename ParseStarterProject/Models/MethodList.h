//
//  MethodList.h
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import <Foundation/Foundation.h>

@protocol MethodListSelector <NSObject>

- (UILabel *)selectedMethodLabel;

@end

@interface MethodList : NSObject

+ (NSMutableArray *)getFlyFishingList;

+ (NSMutableArray *)getSpinFishingList;

@end
