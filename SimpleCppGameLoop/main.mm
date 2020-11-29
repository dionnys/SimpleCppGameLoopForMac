/* Simple C++ Game Loop in macOS
 	This application is a simple implementation of an Objective-C++ game loop in Cocoa for C++ game projects.
	It sets up an application, starts the game loop, and shows a simple way to do a platform abstraction layer on macOS.
 */

#import <AppKit/AppKit.h>
#include "CppApplication.hpp"

/// The game's macOS app delegate.  This class's callbacks allow you to handle messages from macOS.
@interface DemoAppDelegate : NSObject <NSApplicationDelegate>
@end
@implementation DemoAppDelegate

/// Invoked when the user selects "Quit" from the dock.
- (void)handleQuitFromDock:(NSAppleEventDescriptor*)Event withReplyEvent:(NSAppleEventDescriptor*)ReplyEvent
{
	CppApplication::Quit();
}

/// Invoked when the user selects "Quit" from the menu bar.
- (void)handleQuitFromAppMenu
{
	CppApplication::Quit();
}

// Called right before the application opens.  Set up Cocoa stuff, like the menu bar, here.
- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    @autoreleasepool
	{
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
                                                           action:@selector(handleQuitFromAppMenu)
                                                    keyEquivalent:@""];
        [AppMenuImpl addItem:QuitOption];
        [NSApp setMainMenu:MenuBar]; // Register our choices
    }
}

@end

/// Entry point.  Only used to create a native application object and kick off its event loop, which we'll hijack later.
int main(int argc, const char * argv[])
{
	@autoreleasepool
	{
		// Create application
		[NSApplication sharedApplication];

		// Set up custom app delegate
		DemoAppDelegate * delegate = [[DemoAppDelegate alloc] init];
		[NSApp setDelegate:delegate];

		// Activate and launch the app
		[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
		[NSApp setPresentationOptions:NSApplicationPresentationDefault];
		[NSApp activateIgnoringOtherApps:YES];
		[NSApp finishLaunching];

		try
		{
			CppApplication app; // App constructor initializes your game code
			NSEvent *e;

			do
			{
				do // Pump macOS messages
				{
					e = [NSApp nextEventMatchingMask: NSEventMaskAny
										   untilDate: nil
											  inMode: NSDefaultRunLoopMode
											 dequeue: YES];
					if (e)
					{
						[NSApp sendEvent: e];
						[NSApp updateWindows];
					}
				}
				while (e);
			}
			while (app.Run()); // The loop condition itself steps the game logic

		} // The app object's destructor calls game cleanup code upon leaving the try block.
		catch (...)
		{
			// You can handle exceptions from the C++ app here.

			// Note that the application destructor is called upon leaving the 'try' block.  If you disable exceptions
			// in your C++ project, you'll either want to turn the try block into a simple compund statement (an
			// unlabeled block) or implement an explicit cleanup function.

			NSLog(@"C++ exception caught!");
			exit(EXIT_FAILURE);
		}
	}
	return 0;
}
