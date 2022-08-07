# Conventizen

## Table of Contents
- [Conventizen](#conventizen)
  - [Table of Contents](#table-of-contents)
  - [What is it?](#what-is-it)
  - [Who is it for?](#who-is-it-for)
  - [How do I install it?](#how-do-i-install-it)
  - [Usage](#usage)
  - [If you want to know more](#if-you-want-to-know-more)

## What is it?

Conventizen is a very simple, commitizen-like commandline tool for Linux written in bash. As commitizen is, this tool is also oriented towards the so called Conventional Commit style. It wraps the ```git commit``` command, but replaces it.

## Who is it for?

It is made for people that don't really care about a strict commit conventions, but do like to have more understanding of their repo commit history.

## How do I install it?

On Manjaro Linux:

1. Download this file and save it into any folder ```<folder_path>```.

2. Open your bash terminal preferences with your favourite editor (I just used nano).
```bash
nano ~/.bashrc
```

3. Add a new alias inside the bashrc file at the very top (or somewhere idc).
```bash
alias cz="bash <folder_path>/conventizen.sh"
```


## Usage

(If you followed the Installation guide, ```cz``` is equivalent to ```bash <folder_path>/conventizen.sh```.)

```bash
bash <folder_path>/conventizen.sh <commit_type> <scope (optional)>
```

OR (if you followed the installation guide):

```bash
cz <commit_type> <scope (optional)>
```




## If you want to know more

- [Conventional Commit style](https://www.conventionalcommits.org/en/v1.0.0/)
- [commitizen node.js installable command line tool](https://www.npmjs.com/package/commitizen)