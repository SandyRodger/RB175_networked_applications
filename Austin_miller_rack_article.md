# [Austin Miller's Article: Rack, pt 1](https://aumi9292.medium.com/rack-part-i-6bb268dde211)

## Content

  - [What is it?](https://github.com/SandyRodger/RB175_networked_applications/edit/main/Austin_miller_rack_article.md#what-is-rack)
  - [What does it mean for an app to be Rack-based?](https://github.com/SandyRodger/RB175_networked_applications/edit/main/Austin_miller_rack_article.md#what-does-it-mean-for-an-app-to-be-rack-based)
  - [Where it fits in server-side development.](https://github.com/SandyRodger/RB175_networked_applications/edit/main/Austin_miller_rack_article.md#where-does-it-sit-in-server-side-development)
  - [What does Rack do for developers](https://github.com/SandyRodger/RB175_networked_applications/edit/main/Austin_miller_rack_article.md#what-does-rack-do-for-developers)
  - [What are the benefits of using Rack?](https://github.com/SandyRodger/RB175_networked_applications/edit/main/Austin_miller_rack_article.md#what-are-the-benefits-of-using-rack)
  - The frameworks devs use with Rack.
  - We will look at some Rack source code, and send some Rack source code to our browser for demonstration purposes.

## What is Rack?

- A ruby gem that provides an interface between your Ruby program and the application server you're using.
- It facilitates communication between your Rack-based Ruby app and the applications erver you're working with (which could be WEBrick, Puma, Passenger, Unicorn,Thin ...)
- You type in a URL or click a link and this happens:

<img width="670" alt="Screenshot 2023-06-19 at 17 34 02" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/7ab61c2e-6aa7-4031-86ee-32ebc0669a1e">

## What does it mean for an app to be rack-based?

- It's a Rack-based app if it follows a set of specifications that mean Rack knows what to do with it:
  - The application must define a `call` method, which takes 1 parameter, usually called `env`.
  - This `call` method will return and array containing 3 objects:
    -  a String or Int that is the status code (ie `200` for OK)
    -  a Hash object that holds key-value pairs of content headers and their values
    -  an object that responds to Enumerable#each and holds the body of the response.

<img width="719" alt="Screenshot 2023-06-21 at 08 00 56" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/cd28a226-6a36-4252-914c-e722b2854655">

## Where does it sit in server-side development?

- Between the application server and the application.

## What does Rack do for developers?

- Sending requests from the Client to the server:
  - Rack accepts HTTP requests.
  - Formats them into Ruby Datas structures that are easier to handle.
- Sending responses from app-server to app:
  - Takes the return value of your Ruby program (? A program I've written on the app-server I guess?)
  - Spits out some HTTP compliant text to be sent as a HTTP response.
- It looks like this:

<img width="682" alt="Screenshot 2023-06-20 at 16 06 37" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/a48edfad-ba4b-4778-a861-707cb1216373">

## What are the benefits of using Rack?

- Rack frees up your application to focus on:
  - core business logic (?)
    - Making server side changes
    - generating dynamic content.
- ... by taking care of lower level tasks, like handling http requests/responses.
- It provides a standardized way for aservers and apps to communicate. It doesn't matter which app-server you're using, the configuration file stays the same.

## The #call Method

- When call is envoked, the object passed to `env` will be a hash. The hash will have all the information aboput the incoming request. (`HTTP` headers and other environment variables.
- The return value of `call` is used to format a HTTP response for the client.

## What else does Rack need?

- What to run and how to run it.
  - Run a rackup `config.ru` file.
  - or `require 'rack'` and invoke `Rack::Handler::WEBrick.run`

```ruby
require 'rack'

class MyApp
  def call(env)
    body = "<h2>Hello in Style!</h2>"
    ['200', {"Content-Type" => "text/html"}, [body]]
  end
end

Rack::Handler::WEBrick.run MyApp.new
```



## Other notes

- [A comparison of (Rack) web-servers for Ruby web applications](https://www.digitalocean.com/community/tutorials/a-comparison-of-rack-web-servers-for-ruby-web-applications)
    - This started good, but got into the weeds a bit talking about the advantages of different web-servers, like Puma, Thin and Unicorn. I found it too vague to be meaningful to me right now. Probably because I don't know enough about how web-servers work concretely.
   - ['Middleware'](https://en.wikipedia.org/wiki/Middleware)
     - I just had a glance at this. Apparently it is also called 'software glue'


### [Austin Miller's Article: Rack, pt 2](https://aumi9292.medium.com/rack-part-ii-5dc89e9d89d8)
