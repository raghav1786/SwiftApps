## Guided Tour
<img width="488" alt="Screenshot 2022-05-19 at 12 33 00" src="https://user-images.githubusercontent.com/53406407/169230746-31dcb77a-22d0-41f1-8aa1-01983620ff10.png">

## About
Component demonstrates a flexible package component that will:
1. dim the background
2. Mask and Highlight the required View
3. show a tooltip with the specified direction
4. tap on Next to show next tutorial.
5. tap outside to end the tour.

## Requirements
* iOS 14+
* Swift 5.2

## Usage
1. import this Guided Tour package to your app.
2. From Parent View Controller trigger showing Tutorials Tour.
3. Pass the dependencies required for the Tutorial  see [fetchTutorials(request: TutorialRequest)]
4. show the list of passed tooltips for that tour.
For more detailed explanation, check article: https://medium.com/@evandro.hoffmann/flexible-tooltips-in-ios-1ffa5d7d2f36
Happy coding! 😀
