#import "ObjCWindow.h"
#include "CppApplication.hpp"

ObjCWindow * _windowHandle = nil;

/// Create a singleton game window.
@implementation ObjCWindow

+ (void)createWithTitle: (NSString*) windowTitle {
    @autoreleasepool {
        if (!_windowHandle) // Singleton check
        {
            // Set window style
            NSWindowStyleMask style = 0;
            style |= NSWindowStyleMaskClosable;
            style |= NSWindowStyleMaskTitled;
            style |= NSWindowStyleMaskFullSizeContentView;
            style |= NSWindowStyleMaskMiniaturizable;
            
            // Allocate window
            _windowHandle = [[ObjCWindow alloc] initWithContentRect:NSMakeRect(0, 0, 1080, 720)
                                                          styleMask:style
                                                            backing:NSBackingStoreBuffered
                                                              defer:NO];
            
            if ( _windowHandle != nil ) // Creation success check
            {
                // Set window properties
                [_windowHandle setTitle: windowTitle];
                [_windowHandle setDelegate: _windowHandle];
                [_windowHandle setLevel:NSNormalWindowLevel];
                [_windowHandle setCollectionBehavior: NSWindowCollectionBehaviorFullScreenPrimary
                                                        |NSWindowCollectionBehaviorDefault
                                                        |NSWindowCollectionBehaviorManaged
                                                        |NSWindowCollectionBehaviorParticipatesInCycle];
                [_windowHandle setAcceptsMouseMovedEvents: YES];
                
                // Show and center the window
                [_windowHandle makeKeyAndOrderFront:self];
                [_windowHandle center];
            }
            else
            {
                NSLog(@"Error creating Cocoa window.");
            }
        }
        else
            NSLog(@"Warning: [ObjCWindow createWithTitle:] called after a window was already created.");
    }
}

/// Handle when the user clicks the close button.
- (BOOL)windowShouldClose:(NSWindow*)sender
{
    // We don't close the window here.  Instead, we treat this as a request to quit the game.
    // When the main loop breaks, the window will be closed automatically.
    
    CppApplication::Quit();
    return NO;
}

@end
