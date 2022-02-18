**Word game LiveCode**

This repository contains the code associated with Warwick RSEs live coding demo. We created a
simple implementation of a word game inspired by Mastermind/Wordle in Fortran.

The prototype code that I prepared before the video began are in the branch _prototypes_, 
along with a description of the problem we were aiming to solve. The main branch
contains the primary code and its (brief) development history. The code as it was
at the end of the video (including some minor oversights) is in commit _098cd723_ After this, 
we cleaned the code up, added some comments and some docs etc. 

Overall, I spent:
* Approximately 1 hour planning the code and preparing the prototype snippets
* Approximately 1 hour finding a word list and modifying it for my needs
* Approximately 2 hours writing the code (all on video)
* Less than 1 hour adding comments and putting things under git control

**My original plan**

The code outline I had in my notebook, which I then used to get started coding
is copied below. Numbers in brackets denote which "round of editing" I expected
to tackle that part in.

  Read dictionary file into array (2)

  Use fixed word (1) / select target word (2)
  Print word (1)
  Loop
    Input guess for word (1)
    Validate as dictionary word (3)
    
    Check guess for correct letter-correct place (2)
    Check guess for correct letter-wrong place (2)
      (Refactor these once they become clearer (3) )

    Report on match between guess and target (2)

  Loop ends


**My prototypes**

After developing the plan above, I found the following tasks which needed me
to look up some syntax or best practice and decided to develop prototypes
for these sections before tackling the main code. These were:
* Reading a list of words into an array
 * Selecting a word from this at random
 * Checking for presence of a given word in the list
* Getting a fixed length string from a user
* Neatly displaying the guess and some sort of info. on its match to the target

Note that we have technically gone a bit recursive here, since each prototype was
then created following the same sort of process as the main code, just for a 
simpler, more self-contained problem. 

