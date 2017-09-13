# HMan (Hangman) iOS Game Application

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![Awesome Badges](https://img.shields.io/badge/badges-awesome-green.svg)](https://github.com/Naereen/badges)
[![HitCount](http://hits.dwyl.io/thetotaljim/HMan.svg)](http://hits.dwyl.io/thetotaljim/HMan)

> This is a Hangman Game Application written in Swift.  

This project was developed using a test driven software development process. The file structure follows Apple's Model-View-Controller communication pattern. The animations for the hangman were created using iOS Core Graphics framework.  

![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangman3.png)
![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangmanGameOver.png)

## Requirements

Xcode and Apple Developer Account

## Installation

To use this application, download the repository, and open in Xcode.  

## Usage Example

The game begins with a homepage where you select the difficulty level:

![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangmanHome.png)

Then you just play following normal hangman rules!

![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangman2.png)

## Contents 

Here is a list of the included files and their usage in this project:
* Models
  * ``` InitialModel.swift ```
    *  Used to determine the the user's selected difficulty 
* ``` node.h ```
  * data structure for use with parse tree
* ``` token.h ```
  * data structure for tokens generated by the scanner
* ``` scanner.h & scanner.cpp ```
  * used by the parser to create tokens from the source code
* ``` parser.h & parser.cpp ```
  * checks the tokens in the parse tree to check if they conform to the requirements of the course code grammar
* ``` treePrint.h & treePrint.cpp ```
  * display the generated parse tree
* ``` codeGen.h & codeGen.cpp ```
  * uses the parse tree to generate .asm code to be run on the VirtualMachine
* ``` runScript.sh ```
  * bash script to check all included .4280E01 files for success
* ``` VirtualMachine ```
  * executable used to run the .asm code generated by the Compiler
* ``` .4280E01 files ```
  * files written in the grammar specific to the course, designated .4280E01 
* ``` .asm files ```
  * these are examples of the asm code that should be generated by the compiler
 
## Meta

Jim Steimel [@jimsteimel](https://twitter.com/jimsteimel) - jim@thetotaljim.com - www.thetotaljim.com
