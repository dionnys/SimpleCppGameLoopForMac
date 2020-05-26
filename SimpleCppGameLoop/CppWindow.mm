#include "CppWindow.hpp"
#import "ObjCWindow.h"

/// This boils down to a wrapper for the Objective-C version, which actually interfaces with macOS through Cocoa.
void CppWindow::createWithTitle(const char* windowTitle)
{
    [ObjCWindow createWithTitle:[NSString stringWithCString:windowTitle encoding:[NSString defaultCStringEncoding]]];
}
