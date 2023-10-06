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

- Explanation of the app as it will be at the end.
  -  A page with multiple ToDo lists that each have mutiltiple items in them.
  -  You can add items.
  -  You can delete items.
  -  You can edit lists, change their names.
  -  There are success/failure flash messages.
    -  "Happy-path behaviours"
  -  Redirects
  -  error messages

## [What is State?](https://launchschool.com/lessons/9230c94c/assignments/5d2f75a0)

- (No video)
- "Data that persists over time"
- HTTP is a protocol for the interactions between client and server.
- "HTTP is state-less" means every HTTP request is handled seperately. So when a server finishes handling one request, it totally forgets about it and starts on the next. Like a cashier who has no idea who came before the person in front of them (good image?).
- The reality is that servers DO rememeber things between requests. But, doing so requires techniques "built on top of HTTP", and not actually part of HTTP.
- HTTP has no concept of state. We just use it to send information back and forth. When interpreted correctly by both side this creates a system where we can persist across requests. (like threads of a tapestry only making sense as parts of a whole?).

## [Viewing All Todo Lists](https://launchschool.com/lessons/9230c94c/assignments/7bdd9818)

- What are these lists and where are they going to be stored?
  - Some programs might use a "relational data-base.
  - Here we are going to use a 'session-object' provided by Sinatra.
    - This means people don't have to log in to the site ot use it.
    - The con-side is that if they clear their cookies they lose all their data. So in a production application (?) you would want to store the info somewhere where it wouldn't be lost (unless that was it's purpose).
- [1:15] We want to define a data-structure that will properly represent the data that the user will create in the eventual session with todo lists containing todo items.
  - Then we can come back and create a way to modify these structures in the user's session.
  - We will use a hash with 2 values associated with it:
    - name
    - list of todos
  - The list of all lists will be an array of hashes.
 
```ruby
get "/" do
  @lists = [
    {name: "Lunch Groceries"},
    {name: "Dinner Groceries"}
  ]
  erb :lists, layout: :layout
```

- [3:00] Create `lists.erb`
- [4:10] Create count of todo items in each list. Store this in another key in the hash.
- Style point tapping into `<a>` tags, `<p>` tags and `<h2>` tags.
- [8:00] Redirect homepage to lists.

## [Creating a New Todo List](https://launchschool.com/lessons/9230c94c/assignments/2f3d171a)

### User sessions

#### configure block

- Step 1: Add a configure block, which sets up Sinatra to use sessions:

```
configure do
  enable :sessions
  set :session_secret, 'secret'   # we provide a value here so that Sinatra doesn't create its own every time you restart Sinatra, invalidating the users session because the value is used to determine if its the same user.
end
```

- Step 2: assign the session data to `@lists`, with a before block.

```
@lists = session[:lists]
```

### Before block

- So no error will be raised when the program tries to access `session[:lists]`, but there's no value assigned to it.

```
before do
  session[:lists] ||= []
end
```

#### get "lists/new"

- [4:00] Create a path for "/lists/new":

```
get "/lists/new" do
  session[:lists] << { name: "New List", todos: [] }
  redirect "/lists"
end
```

- So when a user visits this path it adds a new value and redirects to the `/lists` page. We'll add a form here later.
- [5:20] Add a link to the lists page.
#### Add form
  - [6:00] Add a form.
#### new_list.erb
  - [6:30] `new_list` erb template.
#### post method

- [8:10] stylesheet not rendering properly. They are referenced relatively and so are expected to be in the same directory as the view file.
- [10:10] Add route for post "/lists".

```
post "lists" do
  session[:lists] << {name: params[:list_name], todos: []}
  redirect "/lists"
end
```

## [URL Discussion](https://launchschool.com/lessons/9230c94c/assignments/258247e2)

#### Adding comments

- "In Sinatra sometimes it can be hard to remember what each handler(?) does, because in the block of code it's not obvious"

#### Choosing URLs

- Write out the routes we want to build, just as a conceptual exercise.
- URL design and conventions aren't dealt with so much here, but in larger applications it becomes important.

## [Clearing Cookies](https://launchschool.com/lessons/9230c94c/assignments/ada10aa2)

- Dev tools
  - resources
    - Cookies, delete
- Create 2 todo-lists

- Download Chrome Extention 'Edit-this-Cookie`.
- Cut cookie data.
- reload the page, make more lists.
- replace cookie value and see previous lists.
- This is "session-hijacking", a serious security issue, solved by using https.

## [Flash Messages](https://launchschool.com/lessons/9230c94c/assignments/cfb2f0cb)

- Messages that appear to the user when they've completed certain actions:
  - Todo added successfully
  - Invalid todo list name.
- The challenge here is this functionality has to be available in `post "/lists" and also "get "/lists" when redirected. We'll solve this by using the session.
- [1:17]

```
post ".lists" do
  session[:lists] << {name: params[:list_name], todos: []}
  session[:success] = "The list has been created." # we add the value here, which we need to access in another request. We do this by adding the value to the list hash
  redirect "/lists"
end
```

- The value has been added, but is not beign displayed, so we change the lists.erb template.
- We need to first check to see if the list has indeed been successfully added.

```erb
<% if session[:success] %>
  <div class="flash success">
    <p><%= session[:success] %></p>
  </div>
<% end %>
```

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
