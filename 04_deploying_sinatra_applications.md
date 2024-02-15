# [Deploying Sinatra Applications](https://launchschool.com/lessons/26c18317/assignments)

## [Introduction](https://launchschool.com/lessons/26c18317/assignments/cf6f9a67)

- (2nd go through 15.2.24)
 - This page talks about Heroku and how we are now ready to make the app accessible to other users.
 - (deploying to Heroku means the project must be a git repository)

## [Configuring an Application for Deployment](https://launchschool.com/lessons/26c18317/assignments/ab12b730)

- (2nd go through 15.2.24)
 - SIX STEPS:
 - [Article about deploying to free platform, 'fly'](https://medium.com/@ntolasaria/how-to-fly-io-b72ab5467abe)
 1. `require "sinatra/reloader" if development?` this line is to prevent the application from reloading while in the production phase.
  - `development?` and `production?` are methods provided by Sinatra, whose return values depend on the `RACK_ENV` variable. This environment variable is automatically set to `production` by Heroku. So if the app is running it will return `true` and otherwise `false`.
 2. Specify Ruby version in the gemfile.
 3.  The following code configures the app to use a production web-server.
  - We've been using WEBrick in development. But Puma is more appropriate for production.
  - This is mainly because WEBrick cannot handle a high number of concurrent requests. If you fail to specify 'Puma' or some such program, your app will use WEBrick and may take super-long to load, or even time-out. 

```
group :production do
  gem "puma"
end
```

- Remember to always run `bundle install` aftrer changing the Gemfile - to prevent bugs spiralling out of control.
4. Create a `config.ru` file which will tell Puma how to start the file:

```
require "./book_viewer"
run Sinatra::Application
```

### [Procfile](https://launchschool.com/lessons/26c18317/assignments/ab12b730)

5. Create a Procfile:

```
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```

- A procfile determines what should be strated-up when the program is started.
- [Heroku article about Procfiles](https://devcenter.heroku.com/articles/procfile)
 - A procfile can specify many types of processes that will be started up when the app is initialized. For instance:
  - the app's web-server (which is what we use it for)
  - different kinds of worker processes.
  - A singleton-process(?), like a clock
  - Tasks to preceed new-releases.
 - It talks a bit about ['dynos'](https://devcenter.heroku.com/articles/dynos), which are apparently "a collection of light-weight Linux containers.
 - Proc files are text files, but they're only called `Procfile` without extention. You keep it in the project root directory. And there's a special format for writing the commands.

6. Test your Procfile locally, like this:

```
$ heroku local
forego | starting web.1 on port 5000
web.1  | Puma starting in single mode...
web.1  | * Listening on tcp://0.0.0.0:5000
web.1  | Use Ctrl-C to stop
```

- Running this command prompts Heroku to download a program called `forego`, which is for reading and running Procfiles.

## [Creating a Heroku Application](https://launchschool.com/lessons/26c18317/assignments/621c4795)

- I hit a wall trying to deploy my Heroku app. The problem was eventually discovered to be me trying to deploy a repo from within a repo.

[thread here](https://launchschool.com/posts/689ace14)


Subject: Deploying to Heroku fails because buildpack not compatible with App

Here is my repo.

Here's a list of some things I've tried:

different Heroku stacks.
different Ruby versions.
different build packs.
deleting the app, copying my files to a new directory and starting from scratch.
The `git push heroku main` command is always returning a variation of the following error message:

```
Enumerating objects: 488, done.
Counting objects: 100% (488/488), done.
Delta compression using up to 4 threads
Compressing objects: 100% (365/365), done.
Writing objects: 100% (488/488), 874.14 KiB | 6.67 MiB/s, done.
Total 488 (delta 219), reused 164 (delta 98), pack-reused 0
remote: Resolving deltas: 100% (219/219), done.
remote: Updated 153 paths from 9fd030d
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Building on the Heroku-22 stack
remote: -----> Using buildpack: heroku/ruby
remote: -----> App not compatible with buildpack: https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/ruby.tgz
remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
remote: 
remote:  !     Push failed
remote: Verifying deploy...
remote: 
remote: !       Push rejected to sandy-todo-list-app.
remote: 
To https://git.heroku.com/sandy-todo-list-app.git
 ! [remote rejected] main -> main (pre-receive hook declined)
error: failed to push some refs to 'https://git.heroku.com/sandy-todo-list-app.git'
```

I can see my app listed on my Heroku profile, but with the message 'build failed'. You'll see that an atricle is suggested. I've read it haven't found a solution.

Can anyone help?


Victor Paolo Reyes:

Hi, @SandyRodger. That was a bit tricky :sweat_smile:. I tried a bunch of stuff with the buildbacks as well. However, it turns out the problem is that the app isn't the root of your git repo. It wasn't detecting the Gemfile and other files because it was checking at the root path of the repo which is the ../RB175_networked_application. I recommend you copy the app to separate folder outside of an existing repo and then initialize a new repo from there that you would then be linking to your heroku app.

I hope this helps. Cheers :thumbsup:!


Sandy Rodger:

Fantastic - yes that has solved the issue. Thanks for taking the time to help me out! The old git repo inside a git repo issue - when will I learn?

Cheers!


Victor Paolo Reyes:

You're welcome!

## [Summary](https://launchschool.com/lessons/26c18317/assignments/2989ba00)

- (1st go through, no notes).
- (2nd go through 15.2.24)
 - This lesson was for deploying the `book_viewer` app.
 - The Procfile is for which processes are provided (what does that actually mean?) by the application and how to start them.
 - `config.ru` tells the server how to start the application. In this program that means requiring the main program and running it.
 - WEBrick's great for development, but sucks for production.
 - Puma on the other hand can handle multiple processes at once. (AKA it is a "threaded" web-server).
 - We put the Ruby version in the Gemfile so the same version is used in production and development.
