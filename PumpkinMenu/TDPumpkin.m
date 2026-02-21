//
//  TDPumpkin.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import "TDPumpkin.h"

@implementation TDPumpkin

+ (NSString *)mapDir {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Blizzard/Warcraft III/Maps/Download"];
}

+ (NSString *)latestVersionOnDisk  {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:[self mapDir]];
    NSMutableArray <NSString *> *found = [[NSMutableArray alloc] init];
    for (NSString *map in enumerator) {
        if ([map hasPrefix:@"PumpkinTD"]) {
            NSCharacterSet *delimeters = [NSCharacterSet characterSetWithCharactersInString:@"-_"];
            NSArray *components = [map componentsSeparatedByCharactersInSet:delimeters];
            NSString *version = components[1];
            //NSString *region = components[2];
            
            [found addObject:version];
        }
    }
    
    NSArray <NSString *> *sorted = [found sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
        if ([[a substringFromIndex:1] floatValue] > [[b substringFromIndex:1] floatValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
     
        if ([[a substringFromIndex:1] floatValue] < [[b substringFromIndex:1] floatValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    return [sorted lastObject];
}

@end
