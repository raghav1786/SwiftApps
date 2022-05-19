# Guided Tour
<img width="488" alt="Screenshot 2022-05-19 at 12 33 00" src="https://user-images.githubusercontent.com/53406407/169230746-31dcb77a-22d0-41f1-8aa1-01983620ff10.png">

## Overview 
[Guided Tour_YML.pptx](https://github.com/raghav1786/SwiftApps/files/8726134/Guided.Tour_YML.pptx)

Description: A reusable component in iOS created as swift package to be re used across multiple apps.

Architecture: VIP
Swift UI support: CW-2373

Dependency diagram:
https://www.figma.com/file/yYjNdLhkMOabzh4mHJYsgJ/CW-1461?node-id=0%3A1

## About
Demonstrates a flexible package component that will:
 1. Creates a overlay
 2. Mask and Highlight the required section/ view
 3. Show a tooltip with the specified direction
 4. Tap on Next to show next tutorial.
 5. Tap outside to end the tour.

## Requirements
* iOS 14+
* Swift 5.2

## Usage
1. Import this Guided Tour package to your app.
2. From Parent View Controller trigger showing Tutorials Tour.
3. Pass the dependencies required for the Tutorial  see [fetchTutorials(request: TutorialRequest)]
4. Show the list of passed tooltips for that tour.
For more detailed explanation, check article: https://medium.com/@evandro.hoffmann/flexible-tooltips-in-ios-1ffa5d7d2f36
Happy coding! 😀
