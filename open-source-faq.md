# Buffer Open Source FAQ
Need to know how open source works at Buffer? This is the place!

### What license do we release software under?
We release all of our open source software under the [M.I.T. license](https://opensource.org/licenses/MIT). It’s very freeing and not restrictive, literally 
the only “ask” it contains is that they include the license with the software.

### What can I open source?
We want to try and share all we can, it’s quite literally who we are as a company. The value of transparency should 
flow over to our codebase as much as it does into all other parts of the company. If you feel you’ve worked on something 
that can help others, by all means - pay it forward and share it to help others out.

One aspect to always consider is security, something we’re always cognizant of even more so since the [hack](https://open.buffer.com/buffer-has-been-hacked-here-is-whats-going-on/). 
Does this code have any API keys? Is there sensitive data hardcoded in any strings? 
Things like this should always be the first question to ask, and if the answer is yes - abstract out the code 
if you can to another repo. Security comes before open sourcing our code, since it ensures our quality of life 
for the code and our awesome customers!

Another gotcha - **if you’re open sourcing a mature repo**, make sure there aren’t any sensitive commits someone 
could go back and view. If you aren’t sure, it’s much easier to just create a fresh repo and add the code there.

### What should I open source?
Even though we want to share all we can, we also want to share code that’s particularly helpful and modular. 
This is why we don’t flip our entire web or mobile repos to public. Would that be neat? Yea, I think so. But it’s 
also not the most actionable service we can provide to the community.

But, some of the hard problems we’ve solved - those are perfect. For example, on iOS there are no stock controls to 
display an image, support pinch to zoom, paging or have a nice black background to focus on the content. We’ve solved 
that problem though, and it was (and still is) a great [example](https://github.com/bufferapp/buffer-ios-image-viewer) of what we like to open source.

### Can I spend time on open source? Is it part of our cycles? Can I spend time contributing back to other open source projects?
We value transparency, and open sourcing our code is part of that ethos, so it’s important to us. If you feel you’re 
about to work on something that’s an open source candidate, remember to code for that from the beginning. If you’re 
asked about any time estimates, include that time along with it.

The free roam period of our cycles is a great spot to look at contributing back to open source projects if you’re not 
in a natural spot to do so.

### How do I open source - what’s it all look like end to end?
- [ ] Double check the code and the repo fit the bill for being secure, and that it contains no sensitive data ✅
- [ ] Consult anyone else on your team if need be, i.e. “Heads up - I’m about to flip this repo to public.” ✅
- [ ] Adding a good README is key for open source, so now is a good time to add one. For a phenomenal example, [check this one out](https://github.com/bufferapp/BufferTextInputLayout).
- [ ] Make the repo public on Github ✅
- [ ] Celebrate and party that we’ve helped out the community some more and shared our knowledge! 🎊
- [ ] Add your open source project to our [open source page](http://bufferapp.github.io/), here’s some info on [how to do that](https://github.com/bufferapp/buffer-opensource). ✅
- [ ] Tweet it out on @bufferdevs - and pat yourself on the back! ✅

### Any general tips?
  - It’s great to think about coding for open source from the beginning. Keeping an “open source” mindset can also 
  lead to objectively better code, since it enforces abstraction inherently and makes you think about processes 
  more proactively. 
  - **//Commenting** is great! **#DocumentAllTheThings**
  - Feel free to let Jordan know you’ve open sourced something so he can tweet it out on @bufferdevs - or feel 
  free to add it to the queue yourself! If you’re not a content contributor to that account, Jordan can add you or 
  you can hop into admin and add yourself, either way!
  - Any other questions you couldn’t quite get answered here? Feel free to tap on the shoulder of someone from your team, 
  or ask your lead any questions. Jordan is also available to answer any questions - and the #eng-opensource channel is 
  a great place to chat too!
