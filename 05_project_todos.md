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

- Adding a link to edit lists. This link will take them to a form where they can change the name of the list
- Solution video:
  - Edit list form will be very similar to the new_list form.
  - The current title of the list will be loaded so the user knows what they are changing.
  - Neat bit of coding (I'm not 100% concentrating...)
  - Loading the invalid list name along with the flash message so the user can compare their input with the message.

## [Delete Todo Lists](https://launchschool.com/lessons/9230c94c/assignments/ace30260)

- Adding the 'delete list' button
- Solution video:
  - copy the "markup" for list title to the list.erb template.

```erb

```

#### choosing between GET and POST

- [1:40] Are you fetching data from the server? Or just sending data back to the server? Is the operation "safe" to do more than once?
- A GET request for instance. If the browser does this multiple times data won't be destroyed, nothing will go wrong. It's safe.
-  Browsers do this all the time, particularly to give the illusion of fast loading times the browser will load content before a user clicks on it.
-  Editing a list is not safe because it destroys the user's data. So it should never be done with e GET request.
-  We'll use a POST. The challenge with that is it can't you can't use a link in plain HTML to make a POST request.
-  So we will make the 'delete list' button a form  with just one button. It looks like a link, but it's actually a button in a form.
-  The button submits the form linked in the button

```edit_list.erb
      <form action="/lists/<%= params[:id]%>/destroy" method="post">
        <button type="submit" class="delete">Delete List</button>
      </form>
```
- Then you write the path in `todo.rb` to handle that deletion:
- [07:30] We use `delete_at`.

```todo.rb
post "/lists/:list_id/todos/:id/destroy" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  @list[:todos].delete_at(todo_id)
  session[:success] = "The todo has been deleted."
  redirect "/lists/#{@list_id}"
end
```

## [Adding Todos to a List](https://launchschool.com/lessons/9230c94c/assignments/046ee3e0)

- Add 'todos' to the lists
- Paste in the markup for a form to `list.erb`
- solution video to write route
  - `:list_id` is the name of the param because there will be different types of objects that need to be identified.

```todo.rb
# Add a new todo to a list
post "/lists/:list_id/todos" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]
  text = params[:todo].strip

  error = error_for_todo(text)
  if error
    session[:error] = error
    erb :list, layout: :layout
  else
    @list[:todos] << {name: text, completed: false}
    session[:success] = "The list was added."
    redirect "/lists/#{@list_id}"
  end
end
```

- Am i even awake right now?
- This video is 18 minutes!!!!!!!!!!!

## [Delete a Todo from a List](https://launchschool.com/lessons/9230c94c/assignments/8c3ed504)

- Functionality to delete single items from items in todo lists. THere will be a little rubbish-bin icon at the far right of each entry.
- Solution video:
  - [4:14 ] Duration

```list.erb
        <form action="/lists/<%= @list_id %>/complete_all" method="post">
          <button class="check" type="submit">Complete All</button>
        </form>
```
- Change `todo.rb` so the post from the `delete` button is handled properly.

```todo.rb
# Delete a todo from a list
post "/lists/:list_id/todos/:id/destroy" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  @list[:todos].delete_at(todo_id)
  session[:success] = "The todo has been deleted."
  redirect "/lists/#{@list_id}"
end
```

## [Sidebar: Fixing Header Link Styles](https://launchschool.com/lessons/9230c94c/assignments/781d35c6)

- There are some css styles missing
  - header styles and icons
  - We find them here in the `applications.css` file:

<img width="918" alt="Screenshot 2023-10-07 at 12 25 56" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/92ccbb7c-7619-47e2-83ce-1502cb9e11fa">

## [Marking Todos as Completed](https://launchschool.com/lessons/9230c94c/assignments/e6f7dc0c)

- Render a checkbox to the left of each item so we can mark it as complete.
- We use the following form code:

```list.erb
<form action="" method="post" class="check">
   <input type="hidden" name="completed" value="" />
   <button type="submit">Complete</button>
</form>
```

#### How to toggle boolean values in a form

- Do we care what the current value is before we toggle to a new value?
- The risk is that you toggle a false value to true, but before the request is processed it turns to true and so is toggled back. This is a real problem apparently.
- So we want to include the desired end-state in the request. It's good for web application design because it mirrors HTTP's stateless architecture.
- Remember, your data can change between the time you view it and the time you change it. So make your interactions as stateless as possible. Don't rely on informaton which is subject to change.
  - like, what happens if a user has 2 tabs open in the same browser?

- solution video [10:43]

```list.erb
    <% sort_todos(@list[:todos]) do |todo, index| %>
      <% if todo[:completed] %>
        <li class="complete">
        <% else %>
          <li>
        <% end %>
```

```todo.rb
# Update the status of a todo
post "/lists/:list_id/todos/:id" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  is_completed = params[:completed] == "true"
  @list[:todos][todo_id][:completed] = is_completed
  session[:success] = "The todo has been updated."
  redirect "/lists/#{@list_id}"
end
```

- [9:00] Todo item styling.

## [Completing All Todos on a List](https://launchschool.com/lessons/9230c94c/assignments/87aa60f3)

- Add a 'complete all' button. We add the button to the view template and then do the back-end coding in `todo.rb`

```list.erb
      <li>
        <form action="/lists/<%= @list_id %>/complete_all" method="post">
          <button class="check" type="submit">Complete All</button>
        </form>
      </li
```

- solution video [8:19]:
  - [04:00] note on duplication. Ripe for refactoring in a later assignment.
  - [05:00] index error.

```todo.rb
# Mark all todos as complete
post "/lists/:id/complete_all" do
  @list_id = params[:id].to_i
  @list = session[:lists][@list_id]

  @list[:todos].each do |todo|
    todo[:completed] = true
  end

  session[:success] = "all todos have been completed"
  redirect "/lists/#{@list_id}"
end
```

## [Using View Helpers to Apply Styles](https://launchschool.com/lessons/9230c94c/assignments/dd71166b)

- Sort the lists on main lists-page by whether they are finished or not.
- Display a fraction describing how much of the list has been completed.
- Solution video [19:12]
  - [02:00] define "completed".
  - A new list has no un-complete tasks, but shouldn't be "complete".
  - [04:00] write a helper method called "list_comlpete?(list)".

```todo.rb
helpers do
  def list_complete?(list)
    todos_count(list) > 0 && todos_remaining_count(list) == 0
  end
```

#### helpers block
  - [05:00]
  - should be at the top of the main code file, with `configure` block and `before` block.
  - [06:00] Methods defined in this block will be available to view templates and to routes defined in the main file.
  - If there are methods that don't need to be available in the views, then they ought not go in the `helpers` block. To make the intention clear. Some methods are intended for common functionality of the routes and some are intended to be used in the view templates.
  - [08:00] hide complete all button if all are already complete.
  - [09:00] problems:
    - `id="todos"` tags are duplicated in `list.erb`
    - What is there's more than one list we want to change?
    - What if we had an item that was partially completed?
    - What if we wanted to make a brand new list which would be styled differently with a totally new class?.
      - [10:00] To do that we would structure the code differently where the id tag would be the result of its own helper method.
      - [11:00] `list_class(list)` helper method.
      - With the `list_class` nethod if we need to make changes to a list's class we can do it all in one place to change the behaviour in all the App.
  - [13:20] Change the 'total complete' figure to a fraction.

```lists.erb
      <a href="/lists/<%= index %>">
        <h2><%= list[:name] %></h2> 
        <p><%= todos_remaining_count(list) %> / <%= todos_count(list) %></p> 
      </a>
```

```todo.rb
  def todos_remaining_count(list)
    list[:todos].select { |todo| !todo[:completed] }.size
  end
```

  - [17:30] Refactor duplication.
  - [18:50] "business logic" ?

## [Sorting and Filtering with View Helpers](https://launchschool.com/lessons/9230c94c/assignments/5046aba5)
## [Deploying to Heroku](https://launchschool.com/lessons/9230c94c/assignments/7d7b4dd7)
## [Summary](https://launchschool.com/lessons/9230c94c/assignments/0aa7a431)
## [Quiz]()
