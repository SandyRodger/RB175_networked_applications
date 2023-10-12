# [Adding JavaScript](https://launchschool.com/lessons/2c69904e/assignments)

## [Introduction](https://launchschool.com/lessons/2c69904e/assignments/c6a612e5)

- Modern web-applications can do a lot of the work on the server before sending HTML / CSS / Javascript.
- Nevertheless thre are times when running code directly within the page in the web-browser is the better move.
- Javascript can do things HTML can't do alone. like:
  - creating drag/drop user-interfaces
  - submitting forms using methods other than `GET` and `POST`.
  - Perform actions without having to reload the page.

## [A JavaScript Primer](https://launchschool.com/lessons/2c69904e/assignments/2d13e2f2)

- This lesson is about writing JavaScript code which executes in the user's browser IN ADDITION TO Ruby code running on the server.
- We'll be using the Jquery library in the client-side code.
- Watch [these three youtube videos](https://www.youtube.com/watch?v=hMxGhHNOkCU&index=1&list=PLoYCgNOIyGABdI2V8I_SWo22tFpgh2s6)
- You needn't learn javascript to proficiency, just get the gist at this point.
- The goal of this lesson is to show you how to build functionality that relies on both client and server-side code.
- There's no JS assessment until after JS210.

## [Including JavaScript Files](https://launchschool.com/lessons/2c69904e/assignments/b5a661d9)

- Downloading and setting up [jQuery](https://jquery.com/)
- Version 2 is not available?
- compressed v. uncompressed assets.
- Creating a `javascripts` directory within `public`.
- `wget`
- Add a reference to jQuery in `layout.erb`.
- script tags are unnecessary.

```layout.erb
<script src="/javascripts/jquery-3.7.1.slim.js"></script>
<script src="/javascripts/application.js"></script>
```

```application.js
console.log("this is a test")
```

- Checking all of this in the inspector.

## [Confirming Destructive Actions](https://launchschool.com/lessons/2c69904e/assignments/7d9fd7b7)

- `confirm` method



## [Making HTTP Requests From JavaScript](https://launchschool.com/lessons/2c69904e/assignments/94ee8ca2)

- I'm getting a bug here. This is a little too much for me right now, so I'll circle back to it.

## [Adding Identifiers to Todo Items](https://launchschool.com/lessons/2c69904e/assignments/af479b47)

- The last step created a bug.
-  Indexing error.
- My brain is not present.

## [Adding Identifiers to Lists](https://launchschool.com/lessons/2c69904e/assignments/a8c93890)

- I'm too depressed to think.

## [Quiz](https://launchschool.com/lessons/2c69904e/assignments/4e784353)

| Question | My answer | correct? | Correction |
| :--- | :---: | :---: | :---: |
|1.||yes||
|2.| |yes||
|3.| |yes||
|4.| |yes||
|5.| A, B, C, D| not B| Unique identifiers are not necessarily sequential. Even if you do use sequential values when creating identifiers, deleting items from the data will result in gaps in the sequence.|
|6.| A, B, D| B, C, D| A. Index numbers change when items in the list change position, which can happen with deletions, rearranging and sorting items, and inserting new items into the list. C. Deleting an item from a list can result in an immediate change in index numbers.
|total|4/6 (67%)|

