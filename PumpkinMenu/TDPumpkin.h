//
//  TDPumpkin.h
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDPumpkin : NSObject

+ (NSString *)saveDir;
+ (NSString *)mapDir;
+ (NSString *)highScore;
+ (NSString *)latestVersionOnDisk;

+ (NSString *)loadCode;

@end

NS_ASSUME_NONNULL_END
