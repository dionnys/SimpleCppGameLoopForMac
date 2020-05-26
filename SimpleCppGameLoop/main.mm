/* Simple C++ Game Loop in macOS
    This application is a simple implementation of an Objective-C++ game loop in Cocoa with a C++ wrapper.
    It sets up an application, starts the game loop, and invokes pure C++ code in CppApplication.cpp.
 
    There aren't a lot of resources around that help folks figure out how to set up a game loop in macOS,
    let alone how to do it in C++.  While more Objective-C will be required to add input, graphics, and audio
    support, this at least demonstrates how to get started with a C++ game engine on Mac.
 */

#import <AppKit/AppKit.h>
#include "CppApplication.hpp"


/// The NSApplication delegate for this app.  The delegate receives messages from macOS and allows you to handle them.
@interface DemoAppDelegate : NSObject <NSApplicationDelegate>
@end


@implementation DemoAppDelegate

/// Custom event callback, invoked when Quit is selected from the Dock menu.
- (void)handleQuitFromDock:(NSAppleEventDescriptor*)Event withReplyEvent:(NSAppleEventDescriptor*)ReplyEvent
{
    [NSApp terminate:self]; // Passes the buck to applicationShouldTerminate:.
}

/// Event callback invoked when the user quits from menu bar, or when [NSApp terminate:] is called.
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)Sender;
{
    if (CppApplication::_isRunning)
    {
        CppApplication::Quit(); // Tell the game the user wants to quit.
        return NSTerminateCancel; // Prevent macOS from quitting for us.
    }
    else
        return NSTerminateNow;
}

/// Called right before the application opens.  Set up Cocoa stuff here.
- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    @autoreleasepool {
        
        // Set the custom callback for when Quit is selected from the Dock menu
        [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                           andSelector:@selector(handleQuitFromDock:withReplyEvent:)
                                                         forEventClass:kCoreEventClass
                                                            andEventID:kAEQuitApplication];
        
        // Set up the menu bar
        NSMenu* MenuBar = [NSMenu new];
        NSMenuItem* AppMenu = [NSMenuItem new]; // Application menu
        [MenuBar addItem:AppMenu];
        NSMenu* AppMenuImpl = [NSMenu new]; // Contents of application menu
        [AppMenu setSubmenu:AppMenuImpl];
        NSMenuItem* QuitOption = [[NSMenuItem alloc]initWithTitle:@"Quit" // Quit option
                                                           action:@selector(terminate:)
                                                    keyEquivalent:@""];
        [AppMenuImpl addItem:QuitOption];
        [NSApp setMainMenu:MenuBar]; // Register our choices
    }
}

// ======================================================================================================================

/// First thing called once the app is running.  This is where we supplant the AppKit event loop with our own.
- (void)applicationDidFinishLaunching:(NSNotification *)Notification {
    @autoreleasepool {
        
        /**
         This try block is for exceptions thrown by your C++ code.  Be careful if you decide to get rid of this -- the scope of the try block is used here to invoke the
         destructor for CppApplication.  [NSApp terminate:] never returns, so the method scope never terminates.  */
        try
        {
            CppApplication app; // Instantiate the C++ app
            
            // The Main loop! -------------------------------
            do
            {
                // Dispatch messages from the OS
                while( NSEvent *e = [NSApp nextEventMatchingMask: NSEventMaskAny
                                                       untilDate: nil
                                                          inMode: NSDefaultRunLoopMode
                                                         dequeue: true] )
                {
                    [NSApp sendEvent: e];
                }
            }
            while (app.Run()); // Invoke the C++ game loop code.
        }
        catch (...)
        {
            // Handle exceptions from the C++ app here.
            NSLog(@"C++ exception caught!");
            exit(EXIT_FAILURE);
        }
        
        // The C++ app's destructor is called automatically after leaving the try block.
        
        [NSApp terminate:self];
    }
}

@end

/// Entry point.  Only used to create a native application object and kick off its event loop, which we'll hijack later.
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [NSApplication sharedApplication];
        [NSApp setDelegate:[DemoAppDelegate new]];
        [NSApp run];
    }
    return 0;
}
