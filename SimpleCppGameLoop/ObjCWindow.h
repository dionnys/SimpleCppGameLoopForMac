#import <Cocoa/Cocoa.h>

/// A class represening a Cocoa window in native Objective-C.  It's an NSWindow that's its own delegate.
@interface ObjCWindow : NSWindow <NSWindowDelegate>

/// Creates a singleton game window with the given  title.
+ (void)createWithTitle: (NSString*) windowTitle;

@end
