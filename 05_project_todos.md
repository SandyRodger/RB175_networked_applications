# [Project Todos](https://launchschool.com/lessons/9230c94c)

## [Introduction](https://launchschool.com/lessons/9230c94c/assignments/c891bf4b)

- web-based
- personal task-manager
- using Sinatra
### Topics:
  - Storing data in the session
  - HTTP methods other than GET
  - Javascript in Sinatra

## [Project Template](https://launchschool.com/lessons/9230c94c/assignments/8356b1b0)

### Config.ru

- This file describes which code needs to be run when the app is started.

```
require './todo'
run Sinatra::Application
```

### Gemfile and Gemfile.lock

```
source "https://rubygems.org"

gem "sinatra, "~>1.4.6"
gem "sinatra-contrib"
```

- `sinatra-contrib` contains the reloader module so you don't have to kill the program and reload it every time you make a change.

### todo.rb

- the main file for this project, where we define:
  -  all of our routes
  -  most of the functionality for this app.
-  require:
  -  sinatra.
  -  sinatra/reloader.
  -  tilt/erubis: allows us to render an erb template.
-  type `ruby todo.rb` to start this app. Then go to `localhost:4567` to see the program.

### Views directory

- (2.15 mins into video)
- layout.erb
  - the main template file for this project.
  - require css files
  - require a font from googlefont
  - header
  - yield out the content is rendered by each route into a `main` container.
 
### Public directory

- (2.47 mins into video)
- Images
- Stylesheets
  - whitespace-reset.css for default padding and spacing to be consistent across different rendereing engines.
  - application.css  is the main stylesheet for this project. We'll reference this to be sure to use the right markup to pick up these styles.

## [Project Demo](https://launchschool.com/lessons/9230c94c/assignments/4687f134)
## [What is State?](https://launchschool.com/lessons/9230c94c/assignments/5d2f75a0)
## [Viewing All Todo Lists](https://launchschool.com/lessons/9230c94c/assignments/7bdd9818)
## [Creating a New Todo List](https://launchschool.com/lessons/9230c94c/assignments/2f3d171a)
## [URL Discussion](https://launchschool.com/lessons/9230c94c/assignments/258247e2)
## [Clearing Cookies](https://launchschool.com/lessons/9230c94c/assignments/ada10aa2)
## [Flash Messages](https://launchschool.com/lessons/9230c94c/assignments/cfb2f0cb)
## [Validations](https://launchschool.com/lessons/9230c94c/assignments/7923bc3a)
## [Refactoring Validations](https://launchschool.com/lessons/9230c94c/assignments/b47401cd)
## [When to Use Validations](https://launchschool.com/lessons/9230c94c/assignments/2f7ac616)
## [Sidebar: Rubocop Warning](https://launchschool.com/lessons/9230c94c/assignments/9a9b017a)
## [Displaying a Single Todo List](https://launchschool.com/lessons/9230c94c/assignments/9a803450)
## [Capturing Template Content For Display Elsewhere](https://launchschool.com/lessons/9230c94c/assignments/e4826299)
## [Editing Todo Lists](https://launchschool.com/lessons/9230c94c/assignments/dc70aa1d)
## [Delete Todo Lists](https://launchschool.com/lessons/9230c94c/assignments/ace30260)
## [Adding Todos to a List](https://launchschool.com/lessons/9230c94c/assignments/046ee3e0)
## [Delete a Todo from a List](https://launchschool.com/lessons/9230c94c/assignments/8c3ed504)
## [Sidebar: Fixing Header Link Styles](https://launchschool.com/lessons/9230c94c/assignments/781d35c6)
## [Marking Todos as Completed](https://launchschool.com/lessons/9230c94c/assignments/e6f7dc0c)
## [Completing All Todos on a List](https://launchschool.com/lessons/9230c94c/assignments/87aa60f3)
## [Using View Helpers to Apply Styles](https://launchschool.com/lessons/9230c94c/assignments/dd71166b)
## [Sorting and Filtering with View Helpers](https://launchschool.com/lessons/9230c94c/assignments/5046aba5)
## [Deploying to Heroku](https://launchschool.com/lessons/9230c94c/assignments/7d7b4dd7)
## [Summary](https://launchschool.com/lessons/9230c94c/assignments/0aa7a431)
## [Quiz]()
