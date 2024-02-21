# [Project: File-based CMS](https://launchschool.com/lessons/ac566aae/home)

## [Introduction](https://launchschool.com/lessons/ac566aae/assignments/79584152)

## [Getting Started](https://launchschool.com/lessons/ac566aae/assignments/d20ebf86)

<img width="1440" alt="Screenshot 2023-10-14 at 10 00 30" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/00c98678-29f3-4880-99f1-7564ccfd289e">

Where my implementation differed from LS:

They ran the app with `bundle exec ruby cms.rb`, where I just used `ruby app.rb`

## [Adding an Index Page](https://launchschool.com/lessons/ac566aae/assignments/c123de3d)

<img width="1440" alt="Screenshot 2023-10-14 at 10 28 54" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/61853da0-4008-49e1-a59e-e2c95d526208">


Where my implementation differed from LS:

- I put the files in a `public` directory. Not cool.
- Moved all with `mv public/* data/*`

- LS used `root = File.expand_path("..", __FILE__)`
- I used `@files = Dir.entries("public/").select {|file| !file.split("").all?(".") }`

BUG:

- I couldn't get the webpage to respond to my changes, until i realised that if a `layout.erb` file exists, the program will default to that, even though you specify another `erb` page (here `index.erb`) in the path. Made more confusing by the inspector calling the page 'index'. (retrospective: ....erm, no it doesn't ?)

- I may one day understand `__FILE__`, but for now FML:
  - "The __FILE__ argument is a well-known Ruby feature, but it's poorly documented. It represents the name of the file that contains the reference to __FILE__. For instance, if your file is name myprog.rb and you run it with the ruby myprog.rb, then __FILE__ is myprog.rb. When we combine this value with .. in the call to expand_path, we get the absolute path name of the directory where our program lives. For instance, if myprog.rb is in the /Users/me/project directory, then File.expand_path("..", __FILE__) returns /Users/me/project. This value lets us access other files in our project directory without having to use relative path names."
  - But the take-away is all you need is `File.expand_path("..", __FILE__)` to reliably give you the name of the directory this file is in.
    - (An alternative is `File.expand_path(__dir__)`)

## [Viewing Text Files](https://launchschool.com/lessons/ac566aae/assignments/2ac6062e)

- My soluton was pretty different but we got there in the end.

## [Adding Tests](https://launchschool.com/lessons/ac566aae/assignments/242be636)

- 

## [Handling Requests for Nonexistent Documents](https://launchschool.com/lessons/ac566aae/assignments/7748eb7b)

## [Viewing Markdown Files](https://launchschool.com/lessons/ac566aae/assignments/98d2fce2)

### Redcarpet Gem
- I had totally forgotten about this. And honestly I'm not sue i get why it's here, even now (RB189)

## [Editing Document Content](https://launchschool.com/lessons/ac566aae/assignments/035eb4d6)

- In Sinatra if you redirect from a GET the status code is 302. For POST it is 303. This is particularly relevant to testing.

## [Isolating Test Execution](https://launchschool.com/lessons/ac566aae/assignments/a23f0109)

- Using different data for testing so the tests don't fail when we use the real program.
  - `File.join` adds the correct seperator for different elements of a path. (`/` for OS X/Linux and `\` for Windows.

## [Adding Global Style and Behavior](https://launchschool.com/lessons/ac566aae/assignments/84acfc0c)


## [Sidebar: Favicon Requests](https://launchschool.com/lessons/ac566aae/assignments/ba2a5d8d)


## [Creating New Documents](https://launchschool.com/lessons/ac566aae/assignments/e1e7cf2a)


## [Deleting Documents](https://launchschool.com/lessons/ac566aae/assignments/79fccabc)


## [Signing In and Out](https://launchschool.com/lessons/ac566aae/assignments/e92bd5bc)


## [Accessing the Session While Testing](https://launchschool.com/lessons/ac566aae/assignments/52d6d56d)


## [Restricting Actions to Only Signed-in Users](https://launchschool.com/lessons/ac566aae/assignments/cf4382fe)


## [Storing User Accounts in an External File](https://launchschool.com/lessons/ac566aae/assignments/c745b2fd)


## [Storing Hashed Passwords](https://launchschool.com/lessons/ac566aae/assignments/537af113)

- salting

## [Next Steps](https://launchschool.com/lessons/ac566aae/assignments/193b81e4)


## [A Note about Security](https://launchschool.com/lessons/ac566aae/assignments/5f01c374)

- "allow-listing"

## [Summary](https://launchschool.com/lessons/ac566aae/assignments/ad1cecd7)


## [Quiz](https://launchschool.com/lessons/ac566aae/assignments/64db5708)

- First go 11/18(61%)
- Second go: 8/18(44%)

1. B, D - CORRECT
2. b  - WRONG. Same mistake as last time. We do store this information in the `Content-Type` header, but it is set in the headers method. `Content-Type` isn't a method Sinatra provides.
3. A, b, c - WRONG. And also D. The `Rack::Test::Methods` call need an instance of a Sinatra app, which is what is returned by the `app` method. 
4. abcd - Not B. The HTTP method is part of the test's set-upo, so it wouldn't make sense to check this.
5. bcd - just c. B is about displaying an error PAGE (read more carefully). D wouldn't require a new request (again, read more carefully)
6. b - CORRECT
7. ba - Not A. Status code is stored as an int, not a string.
8. bc - A, C. RedCarpet will change a the markdown into an HTML string, which then gets sent back to the client.
9. a - CORRECT
10. abd - CORRECT. Running tests doesn't start a web-server.
11. b - And C. We can also pass Rack environment data to the `post` method as a hash. The 2nd argument would be params, the 3rd argument would be env vars.
12. d -   CORRECT
13. d -   CORRECT
14. b - A and D. From within a route we can acess the app env settings with 2 calls: `env` and `request.env`. That's it. `ENV`, which you chose` would return end vars for the local shell!
15. abd - Not A. `erb` doesn't short circuit the request.
16. a - Nope, C. `Bcrypt::Password.create` will just make a new password-hash. `bcrypt_password == password` works because it's using the `BCrypt::Password#==` argument, rather than `String#==`.
17. c - CORRECT
18. a - CORRECT

