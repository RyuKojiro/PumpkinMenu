//
//  main.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import <Cocoa/Cocoa.h>
#import "TDPumpkin.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        NSLog(@"%@", [TDPumpkin latestVersionOnDisk]);
    }
    return NSApplicationMain(argc, argv);
}
