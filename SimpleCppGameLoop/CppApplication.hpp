#ifndef CppApplication_hpp
#define CppApplication_hpp

/**
 A class in which you can start building a game from pure C++ code.  It is instantiated in the main loop in main.mm.
 
 Add your setup and cleanup code to the constructor and destructor.  Add your loop code to Run().
 When you want to quit, call CppApplication::Quit() from anywhere in your code.
 */
class CppApplication
{
public:
	/// Sets a flag that quits the game the next time Run() ends.
	static void Quit();

private:
    /// Constructor for the C++ application class.  Set up your game here.
    CppApplication();
    
    /// The main loop function for your C++ game code.  Step your game logic here.
    bool Run();
    
    /// Destructor for the C++ application class.  Tear down your game here.
    ~CppApplication();

	// Allows main() to create this class only.
	friend int main(int argc, const char * argv[]);
};

#endif /* CppApplication_hpp */
