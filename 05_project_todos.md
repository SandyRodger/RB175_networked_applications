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

```ruby
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

- Problem: the message stays for the whole session, rather than disappearing when the page reloads.
  - We deal with this by deleting the `session[:success]` entry even as we print it out:
  - `session.delete(:success)`

## [Validations](https://launchschool.com/lessons/9230c94c/assignments/7923bc3a)

- NB: There is a general pattern in route organisation:
  - When a valid action takes place => redirect
  - When there is an error => render a page.
- This is due to HTTP's stateless nature. If there is an arror we want to be able to go back and fix it, so we want to have access to our parameters and any IVs in the current route. Redirecting to a new list page loses our access to data tied to the current request.

```ruby
post "/lists" do
  list_name = params[:list_name].strip
  if list_name.size >= 1 && list_name.size <= 100
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  else
    session[:error] = "List name must be between 1 and 100 characters."
    erb :new_list, layout: :layout
  end
end
```

#### session musings

- I THINK I NEED TO UNDERSTAND SESSIONS BETTER. What is `session[:success]` accessing? A key in the `@list` hash. (?) Or is session its own hash? with :success as the key and "The list has been created." as the value? Its one of those 2 I think. And then this session hash remains in existence for the whole session? In the cookie?   

#### strip method

- [06:00]
- [07:50] refactor
- Move flash messages from `new_list.erb` to main `layout.erb` so it can be used for other messages.

## [Refactoring Validations](https://launchschool.com/lessons/9230c94c/assignments/b47401cd)

- Add 'The list name must be unique' error message.
- logic doesn't work at first because the if clause looks at cases in the wrong order.
- Write `error_for_list` helper method
- Potential problem: the method only checks for 1 problem, can't see mutiple failings.
- Final result:

```ruby
post '/lists' do
  list_name = params[:list_name].strip
  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :new_list, layout: :layout
  else
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end
```

## [When to Use Validations](https://launchschool.com/lessons/9230c94c/assignments/2f7ac616)

- (No video)
- Input validation can get super complex. It's been simplified for this project.
- Don't try and control every variation a user can input. You can expect bad data. All you need to do is handle the error and provide a way for the user to recover, by displaying the form again with an appropriate message.
- But don't check for things that can only happen when there's a bug in the code. If there's a bug, fix it.
- Don't write error messages only a dev can understand. These can be helpful to hackers trying to understand the back-end of your program.

## [Sidebar: Rubocop Warning](https://launchschool.com/lessons/9230c94c/assignments/9a9b017a)

```ruby
error = error_for_list_name(list_name)
if error
```

rather than

```ruby
 if error = error_for_list_name(list_name)
```

- because it's not clear whether the dev meant `==` or `=`. in the first piece of code it's more explicit and easier to understand.
  
## [Displaying a Single Todo List](https://launchschool.com/lessons/9230c94c/assignments/9a803450)

- a 1:30 video about what to build
- Solution video:
  - Create a new route for "/lists/:id"

```ruby
get "/lists/:id" do
  @list = session[:lists][params[:id]]
  erb :list, :layout: :layout
end
```
  - Use each with index to map items in the list.
  - Create `list.erb`
  - all parameters passed in Sinatra are strings, so the `:id` value has to be converted to an integer.

## [Capturing Template Content For Display Elsewhere](https://launchschool.com/lessons/9230c94c/assignments/e4826299)

- 'All lists' needs to be up at the top right, for all pages.

#### Sinatra::Contentfor

- [2:00]
- You can define something in your template and then print it out somewhere else.
- [Documentation here](https://sinatrarb.com/contrib/content_for)

```index.erb
<% content_for :some_key do %>
  <chunk of "html">...</chunk>
<% end %>
```

```laypout.erb
<%= yield_conent :some_key %>
```

- must be required: `require sinatra/content_for`
- Then:

```list.erb
<%content_for :header_links do %>
  <a href="/lists">All Lists</a>
<% end %>
```

```layout.erb
<%= yield_content :header_links %>
```

- Do the same with 'new list' link.

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
