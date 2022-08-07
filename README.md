# Conventizen

## What is it?

Conventizen is a very simple, commitizen-like commandline tool for Linux written in bash. As commitizen is, this tool is also oriented towards the so called Conventional Commit style. It wraps the ```git commit``` command, but replaces it.

## Who is it for?

It is made for people that don't really care about a strict commit conventions, but do like to have more understanding of their repo commit history.

## If you want to know more about commitizen or Conventional Commits

- [Conventional Commit style]()
- [commitizen node.js installable command line tool](https://www.npmjs.com/package/commitizen)

## How did I install it?

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