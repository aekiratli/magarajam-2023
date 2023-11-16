# Setting Up Test and Development Environment
* Install Git and Godot
## Setting Up Git
* [Download Git](https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe)
* Install Git
* Make sure it is installed from terminal -> 
* * Open up terminal (Press windows and search cmd, press enter)
* * Type `where git`
* * Output should be like `C:\Program Files\Git\bin\git.exe`
### Importing SSH Key and global credentials
Open terminal again and set up your credentials
*  `git config --global user.email "you@example.com"`
*  `git config --global user.name  "exampleUserName"`
Generate SSH key
* Open terminal again type -> `ssh-keygen` -> just press enter do not enter any prompt
* Go to this path -> `C:\Users\<USERNAME>\.ssh`
* Open `id_rsi.PUB` file and copy all the content
* Go to `https://github.com/settings/keys` and click `New SSH Key` on top right
* Give title and paste your copied content to key section and add new key
Now you can contribute the git repository and make neccesary modifications
## Setting up Godot
* [Download godot v4.1.2](https://github.com/godotengine/godot/releases/download/4.1.2-stable/Godot_v4.1.2-stable_win64.exe.zip)
* Decide where your project folder should be and open up a terminal in that path
* Type `git clone git@github.com:aekiratli/maze-crawler.git`
* Launch godot and click `Import` on top right
* Enter the project folder
* Now you can see what the project looks like