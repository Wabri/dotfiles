# Wabri's Dotfiles

***Forever work in progress***

## About this config

* Focus on **shortcuts**
* High **usability** and **performance**
* **Optimized** for a 60% keyboard
* **Low resources** used
* **Colors and palette**: [Nord Theme](https://www.nordtheme.com/docs/colors-and-palettes)

## Table of contents

- [Why nord?](#why-nord)
- [How I maintain those dotfiles](#how-i-maintain-those-dotfiles)

## Why nord?

I'm using the [nord colorscheme](https://www.nordtheme.com/) because is a perfect balance between dark and light. Don't judge me I love dark themes, but there is something missing in using a total dark theme.
I remember when the first time I riced I spent over a month by changing the palette to find a list of colors that fits, thanks to [mycolor.space](https://mycolor.space/) that helped me a lot.
One day [one of my friend](https://github.com/w00zie) told me that he started using a colorscheme called nord and after some screenshot I decided to try it.
Now I'm using nord everywhere I can, from vim to firefox and I'm well settled.

## How I maintain those dotfiles

I switch from Atlassian bare git repository(https://www.atlassian.com/git/tutorials/dotfiles) to Ansible automation. This add more complexity in order to get more efficency.

## How to install this dotfiles

- Install [Poetry](https://python-poetry.org/) by follow the docs [here](https://python-poetry.org/docs/#installation).

    ```bash
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
    ``` 

- Clone the repository then cd into it:

    ```bash
    git clone https://github.com/Wabri/dotfiles
    cd dotfiles
    ```

- Run poetry install and run ansible-playbook:

    ```bash
    poetry install
    poetry run ansible-playbook -K install.yml 
    ```

Ansible install everything and once is done the system should work.

**NB: run outside tmux otherwise it does not work**

