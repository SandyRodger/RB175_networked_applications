[Working with Sinatra](https://launchschool.com/lessons/c3578b91/home)

## 1	[Introduction](https://launchschool.com/lessons/c3578b91/assignments/b0bee199)

- Sinatra is a web-development framework. Its purpose is to help web-developers speed up development by automating common tasks.
- This is great if you have experience and know what these common tasks are, but if you don't it's confusing.
- For the following section we'll be building on what you learnt in [Packaging code into a project](https://launchschool.com/lessons/2fdb1ef0/assignments) and the [Ruby Core Tools book](https://launchschool.com/books/core_ruby_tools).

## 2	[Rack](https://launchschool.com/lessons/c3578b91/assignments/2a32fe08)

- Not to be confused with Rake.
- 
### Rack applications

#### WEBrick

- We don't want to use our own TCP server to process requests because:
  -  There are more common/robust web-servers in existance already.
-  One that comes with older versions of Ruby is WEBrick.
-  So just like using something from the `Array` class in Ruby, let's use WEBrick instead of creating our own thing.
-  Add the following statement to your Gemfile and run `bundle install`:
  -  `gem 'webrick'`

- Connecting and working with WEBrick is a pain in the ass - make it easier with Rack.
- Rack is a library that helps connecting to WEBrick.
- Rack is also a generic interface that helps devs to connect to web-servers. (it's not just for WEBrick).
- So we're basically using Rack instead of our Ruby code and WEBrick instead of our TCP server.

HERE'S A SENTENCE I DON'T UNDERSTAND:

"When working with Rack applications...
          ...our entire server is comprised of...
                  ...the Rack application and the web server...
                        (which is probably WEBrick, which comes with your Ruby installation)".
                        
SO, I'LL COME BACK TO THAT.

- Most Devs would never write a Rack application except in the simplest of situations. We'll go through it here for teaching purposes.

### [Austin Miller's rack article on Medium](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md)

### [What is Rack in Ruby/Rails?](http://blog.gauravchande.com/what-is-rack-in-ruby-rails)
### [Growing your own web Framework on rack, pt 1](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-1)
### [Growing your own web Framework on rack, pt 2](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-2)
### [Growing your own web Framework on rack, pt 3](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-3)
### [Growing your own web Framework on rack, pt 4](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-4)




3	Sinatra Documentation	Not completed
4	Preparations	Not completed
5	How Routes Work	Not completed
6	Rendering Templates	Not completed
7	Table of Contents	Not completed
8	Adding a Chapter Page	Not completed
9	Code Challenge: Dynamic Directory Index	Not completed
10	Using Layouts	Not completed
11	Route Parameters	Not completed
12	Before Filters	Not completed
13	View Helpers	Not completed
14	Redirecting	Not completed
15	Adding a Search Form	Not completed
16	Improving Search	Not completed
17	Code Challenge: Users and Interests	Not completed
18	Server-side vs. Client-side Code	Not completed
19	Optional: A Quick Analysis of How Sinatra Works	Not completed
20	Summary	Not completed
21	Quiz

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
