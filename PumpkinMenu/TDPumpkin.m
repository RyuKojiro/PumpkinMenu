//
//  TDPumpkin.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import "TDPumpkin.h"

@implementation TDPumpkin

+ (NSString *)saveDir {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Blizzard/Warcraft III/CustomMapData/PumpkinTD"];
}

+ (NSString *)mapDir {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Blizzard/Warcraft III/Maps/Download"];
}

+ (double) parseScore:(NSString *)string {
    if ([string containsString:@"Million"]) {
        return [string floatValue] * 1000000;
    }
    return 0.0;
}

+ (NSString *)loadCode {
    NSString *dir = [self saveDir];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:dir];
    for (NSString *save in enumerator) {
        if ([save containsString:[self highScore]]) {
            NSString *fullPath = [dir stringByAppendingPathComponent:save];
            NSError *e = nil;
            NSString *saveData = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&e];
            assert(!e);
            
            NSArray <NSString *> *lines = [saveData componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            for (NSString *line in lines) {
                if ([line containsString:@"call Preload( \""] && ![line containsString:@"call Preload( \"---"]) {
                    NSArray <NSString *> *parts = [line componentsSeparatedByString:@"\""];
                    return parts[1];
                }
            }
        }
    }
    
    return nil;
}

+ (NSString *)highScore {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:[self saveDir]];
    NSMutableArray <NSString *> *found = [[NSMutableArray alloc] init];
    for (NSString *save in enumerator) {
        if ([save hasPrefix:@"Code"]) {
            NSCharacterSet *delimeters = [NSCharacterSet characterSetWithCharactersInString:@"-_"];
            NSArray *components = [save componentsSeparatedByCharactersInSet:delimeters];
            NSString *score = components[2];
            [found addObject:score];
        }
    }
    
    NSArray <NSString *> *sorted = [found sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
        double A = [self parseScore:a];
        double B = [self parseScore:b];
        
        if (A > B) {
            return (NSComparisonResult)NSOrderedDescending;
        }
     
        if (A < B) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    return [[sorted lastObject] stringByDeletingPathExtension];
    
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
