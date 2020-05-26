# Simple C++ Game Loop for macOS

This project is a simple framework that implements a C++ game loop on macOS. It creates a windowed Mac app with an entry point good for setting up a C++ game or game engine.

A lot of C++ programmers encounter something of an informational brick wall when getting started with macOS game development. C++ is the language of modern game development, but none of macOS’s APIs work with it. To make so much as a window, you need to use either Objective-C or Swift. While those languages each have their strengths, they are not portable, and in many cases produce slower executables than C++ can.

## Objective C++

Professional game engines work around this limitation by utilizing something called Objective-C++. Objective-C++ is a way to compile and link Objective-C and C++ code into the same application. While this does produce applications with the overhead of both the C++ and Objective-C runtimes, this allows developers to program primarily in C++, then use an Objective-C “shell” to work with macOS. This is a complex challenge that often causes programmers to give up on macOS entirely, or to switch to a pre-made game engine like Unity or Unreal.

I’ve developed a framework for adding macOS support to my game engine, Enterprise. Considering how opaque the problem was for me at the outset, I figured I’d upload the framework as its own thing.  Hopefully, this will serve as a foothold for those unfortunate C++ programmers who just don’t know where to begin.

## Instructions

This is a super bare-bones project -- just clone the repo and open the Xcode project. I made this project in Xcode 11, but you should be able to build this on any of the most recent versions, too.

The point of this framework is to allow your portable C++ code to call the shots. The main loop is written in Objective C++, but if you open up CppApplication.cpp, you’ll find a spot to program using pure C++.  You’ll still need to invoke more Objective-C++ to set up things like graphics, audio, and input, but this project shows at least one way to interface the two languages. 
