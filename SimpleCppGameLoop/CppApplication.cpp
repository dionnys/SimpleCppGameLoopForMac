#include "CppApplication.hpp"
#include "CppWindow.hpp"

#include <iostream>

static bool isRunning = true;

CppApplication::CppApplication()
{
    // Game initialization code goes here.
    // ...
    
    std::cout << "Application constructor called!" << std::endl;
    
    CppWindow::createWithTitle("Demo Game Title"); // Create the game window.
}

bool CppApplication::Run()
{
    // Game loop code goes here.
    // ...
    
    std::cout << "Run() called!" << std::endl;
    
    return isRunning;
}

CppApplication::~CppApplication()
{
    // Game cleanup goes here.
    // ...
    
    std::cout << "Application destructor called!" << std::endl;
}

void CppApplication::Quit()
{
    // Handle a request to quit the game here.
    // ...
    
    std::cout << "Quit() invoked." << std::endl;
    
	isRunning = false; // Setting the _isRunning variable to false breaks the main loop.
}
