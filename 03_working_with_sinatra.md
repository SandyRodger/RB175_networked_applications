[Working with Sinatra](https://launchschool.com/lessons/c3578b91/home)

## 1	[Introduction](https://launchschool.com/lessons/c3578b91/assignments/b0bee199)

- Sinatra is a web-development framework. Its purpose is to help web-developers speed up development by automating common tasks.
- This is great if you have experience and know what these common tasks are, but if you don't it's confusing.
- For the following section we'll be building on what you learnt in [Packaging code into a project](https://launchschool.com/lessons/2fdb1ef0/assignments) and the [Ruby Core Tools book](https://launchschool.com/books/core_ruby_tools).

## 2	[Rack](https://launchschool.com/lessons/c3578b91/assignments/2a32fe08)

- Not to be confused with Rake.

### Rack applications

#### WEBrick

- We don't want to use our own TCP server to process requests because:
  -  There are more common/robust web-servers in existence already.
-  One that comes with older versions of Ruby is WEBrick.
-  So just like using something from the `Array` class in Ruby, let's use WEBrick instead of creating our own thing.
-  Add the following statement to your Gemfile and run `bundle install`:
  -  `gem 'webrick'`

- Connecting and working with WEBrick is a pain in the ass - make it easier with Rack.
- Rack is a library that helps connecting to WEBrick.
- Rack is also a generic interface that helps devs to connect to web-servers. (it's not just for WEBrick).
- So we're basically using Rack instead of our Ruby code and WEBrick instead of our TCP server.

HERE'S A SENTENCE I DON'T UNDERSTAND:

"When working with Rack applications our entire server is comprised of the Rack application and the web server (which is probably WEBrick, which comes with your Ruby installation)".
                        
SO, I'LL COME BACK TO THAT.

- Most Devs would never write a Rack application except in the simplest of situations. We'll go through it here for teaching purposes.

## Articles:

### [My notes on Austin Miller's rack article on Medium](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md)

### [`What is Rack in Ruby/Rails?` blog](http://blog.gauravchande.com/what-is-rack-in-ruby-rails)

- Your browser sends a HTTP request to the server.
- The server has 'rails' loaded. It would hand the HTTP request to Rails, but Rails wouldn't understand, so we first pass it to Rack.
- Server passes the HTTP request to Rails which formats this:

```
GET /users HTTP/1.1
Host: localhost
Connection: close
```

- into this:

```
env = {
  'REQUEST_METHOD' => 'GET',
  'PATH_INFO' => '/users',
  'HTTP_VERSION' => '1.1',
  'HTTP_HOST' => 'localhost',
  ...
  ...
}
```

- this `env` is then sent to the app.
- The app does its work and returns its response to the server as a 3 object array:

```
[
  200,
  {
    'Content-Length' => '25',
    'Content-Type' => 'text/html'
  },
  [
    '<html>',
    '...',
    '</html>'
  ]
]
```

- The server can take this response and format it into a response to the client.

- For the app to be a Rack app, it has to contain the following method:

```
class App
  def call(env)
    [
      200,
      { 'Content-Length' => 25, 'Content-Type' => 'text/html' },
      [ "<html>", "...", "</html>" ]
    ]
  end
end
```

- Rails contains this method, which is why is works with Rack

- [An excellent video on Rack](http://railscasts.com/episodes/151-rack-middleware?autoplay=true)
- `rake middleware` command

### [Growing your own web Framework on rack, pt 1](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-1)

- I won't make super-detailed notes for this as I've already made comprehensive notes on Rack for the articles above.
- Here is what you need to make your Ruby code into a Rack application:
  - Create a “rackup” file: this is a configuration file that specifies what to run and how to run it. A rackup file uses the file extension .ru.
  - The rack application we use in the rackup file must be an Ruby object that responds to the method call(env). The call(env) method takes one argument, the environment variables for this application.
  - The call method always returns an array, containing these 3 elements [1]:
    - Status Code: represented by a string or some other data type that responds to to_i.
    - Headers: these will be in the form of key-value pairs inside a hash. The key will be a header name and the corresponding value will be the value for that header.
    - Response Body: this object can be anything, as long as that object can respond to an each method. An Enumerable object would work, as would a StringIO object, or even a custom object with an each method would work. The response should never just be a String by itself, but it must yield a String value.

#### A bug:

The Puma file was being given 2 arguments but iut expected 1. This was because the 2nd parameter was defined as `**options`, so when i deleted the two asterisks it ran fine. It felt great to catch that. Maybe the difference is to be found in the differing versions of Ruby? I'll ask Olly.

### [Growing your own web Framework on rack, pt 2](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-2)

- Tuesday 4th July 2023

### [Growing your own web Framework on rack, pt 3](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-3)

- Wednesday 19th July 2023
- 
### [Growing your own web Framework on rack, pt 4](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-4)




## Sinatra Documentation	
## Preparations
## How Routes Work
## Rendering Templates
## Table of Contents
## Adding a Chapter Page
## Code Challenge: Dynamic Directory Index
## Using Layouts
## Route Parameters
## Before Filters
## View Helpers
## Redirecting
## Adding a Search Form
## Improving Search
## Code Challenge: Users and Interests
## Server-side vs. Client-side Code
## Optional: A Quick Analysis of How Sinatra Works
## Summary
## Quiz

|  | Once | Twice | Thrice | Comprehension | Retention
| :--- | :---: | :---: | :---: | :--- | :---
|1	Introduction|	19.6.23|
|2	Rack	| 19.6.23|
|3	Sinatra Documentation|
|4	Preparations|
|5	How Routes Work|
|6	Rendering Templates|
|7	Table of Contents|
|8	Adding a Chapter Page|
|9	Code Challenge: Dynamic Directory Index|
|10	Using Layouts|
|11	Route Parameters|
|12	Before Filters|
|13	View Helpers|
|14	Redirecting|
|15	Adding a Search Form|
|16	Improving Search|
|17	Code Challenge: Users and Interests|
|18	Server-side vs. Client-side Code|
|19	Optional: A Quick Analysis of How Sinatra Works|
|20	Summary|
|21	Quiz|
