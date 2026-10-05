# AP Computer Science A Work Log

**Period B · 2026–27 · Mr. DeVaughn-Brown · Room U 108**

This repository is your log for the year, and in May it is the reason you can
write a working method with no IDE, no autocomplete, and nothing
underlining your mistakes in red.


## Setup

You accepted this assignment through Classroom 50 and it made you a repository.
Clone it somewhere sane:

```
mkdir ~/version_control
cd ~/version_control
git clone <your-repo-url>
cd ap-csa-fall-2026-student-log-<your-username>
```

> **Everything for this class lives in `~/version_control`.** Never inside
> OneDrive, and never inside iCloud Drive. Cloud sync and git fight each other,
> and git loses in ways that are painful to undo. One folder, every repo, no
> sync, so you always know where your work is.
> **This is why Desktop and Documents are also out.** OneDrive is usually set to
>back those two up for you, so a repo in Documents is a repo inside OneDrive
>whether you meant it or not. `~/version_control` sits outside anything that
>syncs, which is the whole point of it.

> **On Windows, do all of this in Git Bash.** Not Command Prompt, not
> PowerShell. Git Bash comes with Git for Windows and makes every command below
> work exactly as written, which is why there is one set of instructions in here
> instead of two.

If any step below fails, **stop and ask.** Do not paste an error into a chatbot
and run whatever it tells you. That habit is how people destroy repositories,
and separately, it is the exact habit this course spends a year arguing against.

> **Already did this for another of my classes?** Steps 1 through 4 are global
> git settings, set once per computer rather than once per class. Skip to step
> 5.

### 1. Tell git who you are

```
git config --global user.name "Your Real Name"
git config --global user.email "you@sierracanyon.org"
```

Use your real name. Every commit you make this year is signed with it. That is
the point of it.

### 2. Your editor

We set up VS Code on the first day. Tell git to use it:

```
git config --global core.editor "code --wait"
```

The `--wait` matters. Without it, git opens the file and immediately carries on
as if you had already saved, so your commit message comes out empty. With it,
git waits for you to close the tab.

If `code` is "command not found," open VS Code and press `Cmd+Shift+P` on a Mac
or `Ctrl+Shift+P` on Windows, type *Shell Command: Install 'code' command in
PATH*, and hit enter. Then quit your terminal and reopen it. A terminal only
learns about new commands when it starts.

### 3. The terminal setup

```
cd git_files
cp git-commit-template.txt ~/.git-commit-template.txt
git config --global commit.template ~/.git-commit-template.txt
cp git-prompt.sh ~/git-prompt.sh
cp git-completion.bash ~/git-completion.bash
cp bash_profile_course ~/.bash_profile
cd ..
```

Quit your terminal completely and reopen it. Your prompt should now be in color
and should show which branch you are on. **That branch name in your prompt is
not decoration.** It is the thing that stops you committing to the wrong place.

### 4. Two settings that prevent specific miseries

```
git config --global pull.rebase true
git config --global diff.colorMoved zebra
```

Neither of these is cosmetic. Here is what each one is actually stopping.

**`pull.rebase true` stops your history filling with noise.** When you `git
pull` and the branch has moved on without you, git's default is to invent a new
commit whose only job is to glue the two lines of history together. It says
nothing; you did not write it; and after a few weeks your log is half real work
and half *"Merge branch 'main' of github.com:…"*. With `pull.rebase true`, git
instead lifts your commits off, brings the other work down, and sets your
commits back on top: one straight line, every commit one you actually made. It
matters here for a blunt reason: I can tell the difference between four days of
work and one night of it, and that difference is part of your grade. Ten commits
across five days and ten commits after eleven at night look identical in a file
listing and are not the same thing.

**`diff.colorMoved zebra` stops a moved paragraph looking like a rewrite.** By
default `git diff` has exactly two colours: red for gone, green for new. Cut ten
lines from one part of your log and paste them further down and the diff shows
ten red and ten green, identical to having deleted ten lines and written ten
different ones. `zebra` gives moved lines their own colours, so *moved* and
*rewritten* stop looking the same. You want that the first time you reorganise
an entry and cannot tell what you actually changed.

### 5. Run the two entry scripts

```
bash scripts/start-entry.sh
bash scripts/sign-off.sh
```

`bash <script>` hands the file to bash and asks it to run the lines inside. That
is why you do not have to make anything executable, and it is the same command
every time.

The first one starts today's entry. The second one closes it: it carries your
task list forward so you can check things off, and it adds the block you fill in
at the end.

A file should appear in `logs/` named for today's date, with a timestamp header
and a second block below it, and it should open in your editor. If that
happened, setup is done. Run them both today so that neither one is new to you
on a day it matters.

---

## Branches: one per unit

**You never work on `main`.** You work on a branch, and you get a new one for
each unit.

Your branch names are your GitHub username plus the unit:

```
jd12-setup      jd12-unit1      jd12-unit2      jd12-project ...
```

My GitHub username is `jd12`, so those are mine. Yours use your username.

Start a branch like this:

```
git checkout main
git pull
git checkout -b jd12-unit1
git push -u origin jd12-unit1
```

**Hyphens, not slashes.** `jd12-unit1`, never `jd12/unit1`. Git cannot hold a
branch called `jd12` and a branch called `jd12/unit1` at the same time, and the
error it gives you when you try is not one you want to meet on a Tuesday.


## What goes in the log

### File naming

One file per day, in `logs/`, named for the date:

```
logs/2026-09-14.log.md
```

That format sorts correctly when you run `ls`, which is the whole reason for it.
One file holds every entry you write that day.

### The class entry, after every class

Four lines. **The format matters, because a script reads it later.**

```markdown
## M14: Instance methods, doing versus giving back

**Today's one idea:** A method either does something or hands something back.
haveBirthday() changes the Pet and returns nothing, so you cannot print it: the
compiler says 'void type not allowed here'. getAgeMonths() hands back an int, so
you can print it or store it, and if you call it and ignore the answer the work
is just gone.

**Terms released:** Instance method · void · Return type · Dot notation · Chaining

**Shaky:** still guessing about when a returned value has to be caught in a
variable

**Did:** Marked 8 statements compiles / compiles-silently / does-not-compile.
Got 6 of 8; both misses were void.
```

Two rules worth taking seriously:

- **"In your own words" is the whole exercise.** If you copy the sentence off
  the board you have written nothing, because in March you will read it back and
  it will mean exactly as much as it did when it was on the board. If you
  *cannot* put it in your own words, that is not a failure. That is the thing
  that goes on the Shaky line.
- **Leave the `Shaky:` line in even when it is empty.** It is what the study
  guide script looks for, and an empty one is a real answer.

**I read the Shaky lines.** I am telling you that in September so it is never a
surprise. I read them to find out what to teach again, not to judge you for what
you did not get, and the tool only works if you are honest in it.

### Sign-on / sign-off

`start-entry.sh` opens the entry, `sign-off.sh` closes it. Run the pair around
every session, in class and at home both.

What you set out to do, then what you actually did and one honest word about
anything you didn't. "No time" is a complete answer. "Got stuck on question 3"
is a better one, because I can act on it.

### Formatting

1. Markdown. Keep this open in a tab for the first two weeks:
   [markdownguide.org/cheat-sheet](https://www.markdownguide.org/cheat-sheet/).
   You need about six things off it: headings, bold, italic, lists, code, links.
2. Entries run oldest-to-newest down the file, in the order they happened.
3. Every entry starts with a timestamp header. The script writes it for you.
4. **Wrap lines at 80 columns.** The Rewrap extension for VS Code does it with
   one keystroke. This is not fussiness. It is so that `git diff` shows me the
   sentence you changed instead of the whole paragraph, which matters every time
   you open a pull request, because I read the diff before I read the code.

---

## The AI line

Every sign-off entry ends with one line:

```
**AI use:** none.
```

or

```
**AI use:** asked ChatGPT why 7/2 is 3 and not 3.5; wrote the explanation myself.
```

That is the whole policy. **You are not in trouble for using it.** Your answers
are graded, but on whether they show you thought about today's code, not on
whether you got it right, so there is nothing here to gain by cheating. You are
in trouble for not saying so.

Two reasons this line exists. The narrow one is that I need to know whether the
confusion in your log is yours, because that is the only thing I can teach to.
The broad one is that I would rather say this plainly than pretend. AI is
allowed on CSAwesome practice and on your log, which together are a fifth of
your grade. Every mark that actually decides your grade, meaning tests, quizzes,
in-class labs and handwritten free response, happens in this room with me
standing in it, so there is nothing for either of us to police. **Telling me you
used it costs you nothing. Not telling me is the only version that does.**

---

## Committing, and the pull request

Commit every time you write an entry:

```
git add logs/2026-09-14.log.md
git commit
git push
```

`git commit` with no `-m` asks you one question:

```
Are you in class or out of class? Type i for in class, o for out of class:
```

Answer it and the message is written for you, on line 3 of the file VS Code
opens, where you would have typed it:

```
docs: Add sign on for Oct 5th (CW)      in class
docs: Add sign off for Oct 5th (HW)     out of class
```

Read it, save, and close the tab. Git works out sign on or sign off from what
you staged, and the date comes from the log file's name. The scripts in
`scripts/` turn this on for you (`git config core.hooksPath .githooks`).

For any other commit, git opens the normal template and you write the message
yourself. Keep the top line under 50 characters and write it as a command:
*Fix reflection answer for Oct 5th*, not *fixed stuff*.

**Push the same day you write.** A week of entries pushed the night before a
unit test tells me exactly what it looks like, and unlike telling me in the
hallway that you get it, the timestamps are not something either of us gets to
argue about.

### The pull request

A pull request is you saying *this branch is finished, please look at it before
it becomes part of the main record.* That is all it is. It is not a test and it
is not a submission button. It is a request for a reading.

**Open it at the start of the unit**, right after you make the branch, even
though it is empty. Fill in the description as you go. That way I can watch the
work arrive instead of meeting all of it at once on test day.

**Merge it at the unit test**, after I have reviewed it. Then make the next
branch and open the next PR.

### What my review looks like

A comment on your PR with a score out of 12, one thing that worked, and one
question. **The question is the part that matters.** You do not have to answer
it in writing, but you should be able to answer it out loud if I ask you in
class, and sometimes I will.

---

## The payoff: `study-guide.sh`

This is why the four-line format is worth the discipline.

```
bash scripts/study-guide.sh              everything you have written
bash scripts/study-guide.sh 2026-10      just October
bash scripts/study-guide.sh --shaky      only the things you flagged
```

It writes `study-guide.md` at the top of the repository. That file is
git-ignored, so rebuilding it never clutters your commits, so run it as often as
you like.

**Use `--shaky` two days before every test.** It gives you a list, in your own
words, of exactly the things you did not understand at the moment you did not
understand them. Anything still on that list is your study plan. Anything you
can now explain out loud, delete from the log. Deleting it is the point, and git
remembers it was there.

Before the midterm on **14 December** and again before the AP exam on **12
May**, run it with no arguments and read the whole thing. It takes about fifteen
minutes and it is the single highest-value hour of revision available to you,
because it is made entirely of your own thinking rather than somebody else's
summary.

---

## Grading

The log is part of **Daily log & reflections**, which is 10% of your grade and
is scored on two things separately: **whether you kept it** and **what your
answers say.** Six of those ten points are the answers, spot-graded one day in
three and picked after the fact, so there is no guessing which day counts. The
other four are discipline: sign-on/sign-off pairing, same-day commits,
completeness.

- A class entry for **every meeting**, committed before the next one.
- A sign-on/sign-off pair for **any work you do outside class**.
- **Same day, or it is late.** Git records when you wrote it. A thoughtful
  reflection committed three weeks later earns the answer points and not the
  discipline points, and that is the whole signal.
- Miss more than **six** class entries in a semester and it stops being free.
  Come see me before that happens, not after.

Nothing in here is scored on how smart it sounds. I am not grading the writing.
I am reading it.

---

## Fixing things

**I committed to `main`.** Nothing is lost.

```
git branch jd12-unit1          # if the branch doesn't exist yet
git checkout jd12-unit1
git merge main
git checkout main
git reset --hard origin/main
git checkout jd12-unit1
```

**My push was rejected.** Somebody, probably you on another machine, pushed
first. `git pull`, then push again.

**I have a merge conflict.** Stop. Screenshot it and post it to Piazza.
Conflicts are completely routine and completely confusing the first time, and
you will learn more from three minutes with me than an hour of guessing.

**GitHub is asking for a password and rejecting mine.** GitHub does not accept
account passwords for git any more. You need a personal access token. See the
setup card, or ask.

---

## Getting help

Ask me, or post to **Piazza**, which is our class board and the right place for
anything that is not urgent. Include the **exact** command you ran and the
**exact** error, as text, not as a description. "It didn't work" cannot be
helped; a screenshot can.

Answering somebody else's question on Piazza is worth as much as asking a good
one. It is also the single best predictor I know of who ends up understanding
this material.
