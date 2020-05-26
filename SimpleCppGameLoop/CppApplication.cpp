#include "CppApplication.hpp"
#include "CppWindow.hpp"

#include <iostream>

bool CppApplication::_isRunning = true;

CppApplication::CppApplication() {
    // Game initialization code goes here.
    // ...
    
    std::cout << "Application constructor called!" << std::endl;
    
    CppWindow::createWithTitle("Demo Game Title"); // Create the game window.
}

bool CppApplication::Run() {
    // Game loop code goes here.
    // ...
    
    std::cout << "Run() called!" << std::endl;
    
    return _isRunning;
}

CppApplication::~CppApplication() {
    // Game cleanup goes here.
    // ...
    
    std::cout << "Application destructor called!" << std::endl;
}

void CppApplication::Quit() {
    // Handle a request to quit the game.
    // ...
    
    std::cout << "Quit() invoked." << std::endl;
    
    _isRunning = false;
}
