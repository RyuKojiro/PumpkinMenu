//
//  AppDelegate.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import "AppDelegate.h"
#import "TDPumpkin.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;

@property (strong) NSStatusItem *item;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    _item = [bar statusItemWithLength:70];
    _item.title = [NSString stringWithFormat:@"🎃 %@", [TDPumpkin latestVersionOnDisk]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
