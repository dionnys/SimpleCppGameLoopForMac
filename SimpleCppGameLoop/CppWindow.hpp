#ifndef CppWindow_hpp
#define CppWindow_hpp

/// A C++ class representing a game window.
class CppWindow
{
public:
    /// Creates a singleton game window.
    static void createWithTitle(const char* windowTitle);
};

#endif /* CppWindow_hpp */
