#ifndef CppApplication_hpp
#define CppApplication_hpp

/**
 The class which contains your C++ game code.  Instantiated in main.mm.
 
 Add your setup and cleanup code to the constructor and destructor.  Add your loop code to Run().
 When you want to quit, call CppApplication::Quit() from anywhere in your code.
 */
class CppApplication
{
public:
    static bool _isRunning;
    
    /// Constructor for C++ application class.  Set up your game here.
    CppApplication();
    
    /// C++ method: Program your game loop here.
    bool Run();
    
    /// Destructor for C++ application class.  Tear down your game here.
    ~CppApplication();
    
    /// C++ method: Sets a flag that quits the game when Run() next ends.
    static void Quit();
};

#endif /* CppApplication_hpp */
