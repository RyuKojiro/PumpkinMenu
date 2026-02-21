//
//  TDPumpkin.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import "TDPumpkin.h"

@implementation TDPumpkin

+ (NSString *)latestVersionOnDisk  {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Blizzard/Warcraft III/Maps/Download"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:path];
    for (NSString *map in enumerator) {
        if ([map hasPrefix:@"PumpkinTD"]) {
            NSCharacterSet *delimeters = [NSCharacterSet characterSetWithCharactersInString:@"-_"];
            NSArray *components = [map componentsSeparatedByCharactersInSet:delimeters];
            NSString *version = components[1];
            NSString *region = components[2];
            
            return version;
        }
    }
    
    return nil;
}

@end
