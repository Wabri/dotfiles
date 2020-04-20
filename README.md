# Wabri's Dotfiles

A total nord dotfiles.

## Kitty

The page of the [kitty site](https://sw.kovidgoyal.net/kitty/) said: the fast, featureful, GPU based terminal emulator. Fast is fast for now, I confirm the featureful and I presume it use the GPU.

I love to use the [JetBrains](https://www.jetbrains.com/lp/mono/) font: the lignatures, the letters and the semplicity of the shape:

![kitty-font](.dotfiles_resources/kitty-font.png)

I found useful the build-in tabs and windows feature:

![kitty-tabs](.dotfiles_resources/kitty-tabs.png)

Then I create some personal shortcuts using the alt as kitty modifier:

| ---| Description |
| ctrl+shift+c | copy |
| ctrl+shift+v | paste |
| kitty_mod+u | hints urls |
| kitty_mod+enter | new window |
| kitty_mod+r | resizing window |
| kitty_mod+] | move to next window |
| kitty_mod+[ | move to previous window |
| kitty_mod+k | move window to top |
| kitty_mod+t | new tab |
| kitty_mod+w | close tab |
| kitty_mod+i | set tab title |
| kitty_mod+l | next tab |
| kitty_mod+h | previous tab |
| kitty_mod+shift+L | move tab forward |
| kitty_mod+shift+H | move tab backward |
| kitty_mod+1 | go to tab 1 |
| kitty_mod+2 | go to tab 2 |
| kitty_mod+3 | go to tab 3 |
| kitty_mod+4 | go to tab 4 |
| kitty_mod+5 | go to tab 5 |
| kitty_mod+shift+E | edit config file |
| kitty_mod+shift+U | unicode input |

## Bash

I use [bash-it framework](https://github.com/Bash-it/bash-it) with some patches I made and one new theme created by me:

* [.bashrc](.bashrc)
* [.bash_aliases](.bash_aliases)
* [.bash_it/themes/wabri/wabri.theme.bash](.bash_it/themes/wabri/wabri.theme.bash)

### Bashrc

Some mentions on this configuration:

* Vim motion abilitate:

    ```Bash
    set -o vi
    ```
    
* The must have ignore case abilitate:

    ```Bash
    bind 'set completion-ignore-case on'
    ```

* Some history settings and more (if you are curious there are many comments on the script)

### Bash aliases

Mine aliases are:

* Replace the old **ls,ll and la** with [exa](https://the.exa.website/):

![ls-ll-la](.dotfiles_resources/ls-ll-la.png)

* Created some **cd** aliases:

![cds](.dotfiles_resources/cds.png)

* Shortcuts for **apt**:

![apts](.dotfiles_resources/apts.png)

* Alias for [thefuck](https://github.com/nvbn/thefuck):

![fuck](.dotfiles_resources/fuck.png)

* Dotfiles command to update this repo ([How I maintain those dotfiles](#how-i-maintain-those-dotfiles)):

![dotfiles_alias](.dotfiles_resources/dotfiles_alias.png)

There are a lot of aliases that you can find also on the general aliases of [bash-it](https://github.com/Bash-it/bash-it).

## Why nord

I'm using the [nord colorscheme](https://www.nordtheme.com/) because is a perfect balance between dark and light. Don't judge me I love dark themes, but there is something missing in using a total dark theme.
I remember when the first time I riced I spent over a month by changing the palette to find a list of colors that fits, thanks to [mycolor.space](https://mycolor.space/) that helped me a lot.
One day [one of my friend](https://github.com/w00zie) told me that he started using a colorscheme called nord and after some screenshot I decided to try it.
Now I'm using nord everywhere I can, from vim to telegram and I'm well settled.

## How I maintain those dotfiles

I created a .dotfiles directory on my home and init a bare repository on it:

```Bash
mkdir ~/.dotfiles
git init --bare ~/.dotfiles
```

I defined an alias:

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

I set the remote:

```Bash
dotfiles remote add origin git@github.com:Wabri/dotfiles.git
```

And now I can update my dotfiles wherever I am and whenever I want, by simply use the git command, example:

```Bash
dotfiles add .bashrc
dotfiles commit -m "Update (bashrc)"
dotfiles push 
```

Atlassian made a tutorial about this method, you can find the post here [**The best way to store your dotfiles: A bare Git repository**](https://www.atlassian.com/git/tutorials/dotfiles).

