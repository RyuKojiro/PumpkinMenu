//
//  AppDelegate.m
//  PumpkinMenu
//
//  Created by Daniel Loffgren on 2/20/26.
//

#import "AppDelegate.h"
#import "TDPumpkin.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSMenu *menu;
@property (strong) NSStatusItem *item;

@property (strong) IBOutlet NSMenuItem *save;
@property (strong) IBOutlet NSMenuItem *map;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *latestVersion = [TDPumpkin latestVersionOnDisk];
    latestVersion = latestVersion ? latestVersion : @"Not found!";
    
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    _item = [bar statusItemWithLength:70];
    _item.title = [NSString stringWithFormat:@"🎃 %@", latestVersion];
    _item.menu = _menu;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (IBAction)openMapDir:(id)sender {
    NSURL *url = [NSURL fileURLWithPath:[TDPumpkin mapDir]];
    NSWorkspace *w = [NSWorkspace sharedWorkspace];
    [w openURL:url];
}

- (IBAction)openSaveDir:(id)sender {
    NSURL *url = [NSURL fileURLWithPath:[TDPumpkin saveDir]];
    NSWorkspace *w = [NSWorkspace sharedWorkspace];
    [w openURL:url];
}

@end
