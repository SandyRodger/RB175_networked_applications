# [Handling Requests Manually](https://launchschool.com/lessons/cac53b94/assignments)

## [Introduction](https://launchschool.com/lessons/cac53b94/assignments/9cd19cf9)

- What is involved with responding to http requests the hard way (ie. without the nifty tools we'll learn about in a sec)
- Rememeber that a http exchange is just a client and server sending text to each other.
- You won't need to use this technique in most production application, but the deep-dive is a great learning tool.

## [Coding Along with This Course](https://launchschool.com/lessons/cac53b94/assignments/1cd7539f)

- In the previous course it was said that a server is actually lots of different things working together, possibly in different places. 
- Well, in this part of the course we aren't using a database so the server is only one thing: the application server.
- This is a typical way for devs to work. If they're only using their personal machine, nothing more is necessary and you can just focus on the application code.
- It's when the code is deployed that other parts become necessary.
- This part of the course will concentrate on:
  - application code
  - HTTP
- and ignore:
  - server infrastructure:
    - web servers.
    - data stores.
- TCP is the protocol for HTTP requests, so is what we'll be looking at here.
- Keep the following image in mind while we're building our own TCP(AKA HTTP) server:

<img width="869" alt="Screenshot 2023-06-14 at 16 21 26" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/285b31b4-d5ae-46d7-9796-27b12bc596f7">


## [A Simple Echo Server](https://launchschool.com/lessons/cac53b94/assignments/a32ebc5e)

<img width="532" alt="Screenshot 2023-06-15 at 13 21 22" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/cf3f8f52-f4bc-4d25-80a2-80676aec73d2">

<img width="1220" alt="Screenshot 2023-06-15 at 13 16 19" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/9567de53-90b2-4a92-8ddd-1ba37c3cb226">

- This isn't working. Here are some solutions I'm trying:
  - A million things on chrome and Safari...
  - Download Firefox and try it on there. OK this was apparently a solution.

## [Parsing Path and Parameters](https://launchschool.com/lessons/cac53b94/assignments/4d46009e)

(Revise 3.2.24)

- We output onto the browser and input in the URL
- The program outputs a number between 1 and 6, like a dice.
- `server = TCPServer.new("localhost", 3003)`
- The URL is input to the program.
  - `http://` is the protocol
  - `localhost` is the path
  - `:3003` is the port
  - `/` is the path
  - `?rolls=2&sides=6` is the params (or `/rolls/2/sides/6`)
    - The style you choose depends on the style of program and type of data. Here the latter implies that sides is somehow a sub-type of rolls. So it's not appropriate.

## [Sending a Complete Response](https://launchschool.com/lessons/cac53b94/assignments/65b0e271)

- The only required thing in a HTTP response is the status line. The video states that headers and body are too, but they are in fact merely valid and expected.
- `<pre>` tags to preserve the line-breaks.
- Headers are meta-data that come in a key-value format and tell the browser how to interpret the rest of the response.
  - `Content-Type: text/html"

## [Persisting State in the URL](https://launchschool.com/lessons/cac53b94/assignments/3e3dd1f9)

- (1st go round notes) Cool!
- (Returning notes on 3.2.24)
  - Http is stateless, so there's no place to store info between requests. There are work-arounds, but they aren't HTTP.
  - So for this program, which uses a current number, the number must be passed in as part of the request in the URL.
  - (remember `nil.to_i` returns 0)
  - - `client.puts "<a href='?number=#{number + 1}'>Add one</a>"`

## [Dealing with Empty Requests](https://launchschool.com/lessons/cac53b94/assignments/423845e1)

- (1st go round notes) I cant seem to emulate this error
- (Returning notes on 3.2.2
  - In this video the narrator says basically, "we don't know why the browser has dropped the connection, and it's too complicated to find out, so write a line of code that skips any nil value request lines" - which is nice to hear. 

## [Summary](https://launchschool.com/lessons/cac53b94/assignments/d5f4cb26)

- HTTP is text based, so this lesson was all about messing with it entirely with text. Just as a learning tool though.
- HTTP is made up of TCP. This is the protocol at the Transport layer. Its job is talking between 2 computers. It's the layer right below HTTP.
- URLs are made up of different parts (I knew this)
- Params are added with `&`s. Obvs.
- HTTP is stateless which means you have to wiggle your bottom to make it look like it isn't. Stateful interactions can be built atop HTTP.


## Overview

|  | Once | Twice | Thrice | Comprehension | Retention
| :--- | :---: | :---: | :---: | :--- | :---
|1	Introduction| 14.6.23|3.2.24|
|2	Coding Along with This Course| 14.6.23|3.2.24|
|3	A Simple Echo Server|15.6.23|3.2.24|
|4	Parsing Path and Parameters|16.6.23|3.2.24|
|5	Sending a Complete Response|16.6.23|3.2.24|
|6	Persisting State in the URL|17.6.23|3.2.24|
|7	Dealing with Empty Requests|17.6.23|3.2.24|
|8	Summary|17.6.23|3.2.24|
