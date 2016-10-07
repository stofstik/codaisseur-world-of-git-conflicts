# Git conflicts

Merging should always be done on Github using the pull request option. This is a good way to keep track of changes.

Conflicts appear when git cannot merge your files automatically. This is because someone else worked on the same code as you did. 

Conflicts should **ALWAYS** be fixed before you merge your branch to master. So always test before you commit.

You fix a conflict by reading the file and the previous and understanding the reason for the conflict. 

If you cannot solve a conflict by yourself, you should ask the person who created the code you are conflicting with because you don't want to break their work. Force pushing **NEVER** solves a conflict.
  
## INTRO  

There are several people working on the /show page of the dinosaur project. They all have their own task. 

> Ben: The dinosaur name should be a H2 and the site title should become a h1. Also the h2 needs styling and add the h1

> Wouter: The dinosaur name needs a css class added to it. It will make it Blink. Also add a background of stars.

> Miriam: The dinosaur name needs an era it was living in. Also add the era in the DB and seeds. 

> Matt: A dinosaur name needs the sound it makes. Also add the sound in the DB and seeds.

---

- We will practice the proper workflow for merging work in git. 
- The four branches with work have been premade.
- Conflicts will arise when you try to make a pull request and we will solve them with a mergetool.
- You will merge from the branch to master by creating a pull request.
- Before you merge a pull request, you always test it on your local machine. 

## 0. Setup

Its going to take some effort to fully clone a repository with all its branches and copy it over to your own.

Make a full local copy of the exercise repository

- Git clone `git clone git@github.com:Codaisseur/world-of-merge-conflicts.git`
- `cd world-of-merge-conflicts`
- `git fetch`
- `git checkout -b feature/era origin/feature/era`
- `git checkout -b feature/h2 origin/feature/h2`
- `git checkout -b feature/sound origin/feature/sound`
- `git checkout -b feature/stars origin/feature/stars`
 
Create a new repository on your github account and push your local copy to it. 

- `git remote add new-origin git@github.com:your_account/new-repository.git`
- `git push --all new-origin`
- `git remote rm origin`
- `git remote rename new-origin origin`

- check on github if you have all the branches now in your own repository. It should show 4 branches

## 0. Install a mergetool: Meld

**If you already have a working mergetool you are happy with, you can skip this step.** 

### OSX 

- Download meld here: https://yousseb.github.io/meld/
- edit your `~/.gitconfig` and add the following lines (`nano ~/.gitconfig` in your terminal)

```
[diff]
  tool = meld
[difftool]
  prompt = false
[difftool "meld"]
  trustExitCode = true
  cmd = open -W -a Meld --args \"$LOCAL\" \"$PWD/$REMOTE\"
[merge]
  tool = meld
[mergetool]
  prompt = false
[mergetool "meld"]
  trustExitCode = true
  cmd = open -W -a Meld --args --auto-merge \"$PWD/$LOCAL\" \"$PWD/$BASE\" \"$PWD/$REMOTE\" --output=\"$PWD/$MERGED\"
```

### Linux

- Install with package manager: `sudo apt-get install meld`
- `git config --global merge.tool meld`
- `git config --global  diff.guitool meld`

## 1. Check if the project works

- Make sure you are on the master branch
- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`
- `rails s`

- Test in your browser if it all works. You should see 3 dino's and links to their show page

## 2. Add Bens work

So to start off easy, ben starts by merging his work on the header. He changes the h1 to a h2 and adds some style

- Go to github
- Go to the overview of branches
- Create a pullrequest for features/h2
- Merge it 

## 2. Add Wouters work

- Create a pullrequest for features/stars
- You cannot merge it automatically
- Go to terminal to the directory of the project

### 2.1 Update to the latest versions

- Pull the latest master into the master
- `git checkout master`
- `git pull origin master`
- Checkout branch feature/stars `git checkout feature/stars`

### 2.2 Merge

- Start the merge with master by doing `git merge master`

```bash
Auto-merging app/views/dinosaurs/show.html.erb
CONFLICT (content): Merge conflict in app/views/dinosaurs/show.html.erb
Auto-merging app/assets/stylesheets/dinosaurs.scss
CONFLICT (content): Merge conflict in app/assets/stylesheets/dinosaurs.scss
Automatic merge failed; fix conflicts and then commit the result.
```

- Oops, there are some conflicts.
 
### 2.3 Resolve issues
 
- `git mergetool` to launch meld
- this should display a 3 pane interface to help you with merging
- On the left is your current source, On the right is the remote source, In the middle in the result
- If you make a mistake during the merge, use `git merge --abort` and start again with `git merge master`
- For the `dinosaurs.scss` file, save all the css classes
- Save the file and close meld
- For the `show.html.erb` file, keep the changes to the class and wrapping with the div but manually change the h1 to a h2. This will preserve the change done.
- Save the file and close meld

### 2.4 Test it

- Start the rails server to check the progress
- You should see a fancy background and a blinking header

### 2.5 Finish the merge

- `git commit -m 'Merged master'`
- `git push origin feature/stars`
- Go to github
- Merge the pullrequest

## 3 Add Miriams work

- Create a pullrequest for features/stars
- You cannot merge it automatically
- Go to terminal to the directory of the project

###3.1 Update to the latest versions

- Pull the latest master into the master
- `git pull origin master`
- Checkout branch feature/era `git checkout feature/era`

###3.2 Merge

- Start the merge with master by doing `git merge master`

```
Auto-merging app/views/dinosaurs/show.html.erb
CONFLICT (content): Merge conflict in app/views/dinosaurs/show.html.erb
Auto-merging app/assets/stylesheets/dinosaurs.scss
CONFLICT (content): Merge conflict in app/assets/stylesheets/dinosaurs.scss
Automatic merge failed; fix conflicts and then commit the result.
```

###3.3 Resolve issues
 
- `git mergetool` to launch meld
- If you make a mistake during the merge, use `git merge --abort` and start again with `git merge master`
- For the `dinosaurs.scss` file, save all the css classes
- Save the file and close meld
- For the `show.html.erb` file, keep all the changes we made earlier by selecting the version on the right
- Add the part where we added a html `<small>` tag for the era name
- Save the file and close meld

###3.4 Test it

- This change contained a database change too. So you have to run `rails db:migrate` and `rails db:seed` 
- Start the rails server to check the progress 
- The merge worked but we forgot a issue with the css because of the change to `<h2>` Fix this by changing `h1 small{` to `h2 small{` in the dinosaur css file.

###3.5 Finish the merge

- `git commit -m 'Merged master'`
- `git push origin feature/era`

##4 Add Matts work

Repeat the same process as before



