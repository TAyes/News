# Chope Group's Senior iOS Engineer Assessment
Swift Assessment Test 

## Building And Running The Project 
* Swift 5.0+
* Xcode 11.5+
* iOS 11.0+

# Getting Started
- If this is your first time encountering swift/ios development, please follow [the instructions](https://developer.apple.com/support/xcode/) to setup Xcode and Swift on your Mac.


## Setup Configs
- Checkout master branch to run latest version
- Open the project by double clicking the `News.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app

```
// App Settings
APP_NAME = News
PRODUCT_BUNDLE_IDENTIFIER = com.News.News
```

# Build and or run application by doing:
* Select the build scheme which can be found right after the stop button on the top left of the IDE
* [Command(cmd)] + B - Build app
* [Command(cmd)] + R - Run app

## Architecture
This application uses the Model-View-ViewModel (refered to as MVVM) UI architecture,


## Structure

### Modules
- Include 
	*NewsDetail/NewsDetailTableViewController, 
	*NewsList/(View/NewsTableCell,NewsViewModel,NewsUIViewController),(Model/New).

### Navigation
- Include Navigator, Destination

### Protocol
- Include NewsLoader
- Include LoadImage

### NetworkServices
- Include NetworkManager

### Common
- Include Network+Error,  Observable ..etc

### Extensions
- Include UITableView+Cell, Date+Time..etc


#### screen shots:

![News List (White) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.26.01.png)
![News Detail  (White) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.26.13.png)
![Saved News  (White) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.26.05.png)

![News List (dark) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.25.21.png)
![News Detail (dark) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.25.31.png)
![Saved News (dark) scene](https://github.com/TAyes/News/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-03-05%20at%2018.25.40.png)
