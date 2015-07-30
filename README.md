Bash dotfiles
=============
This is almost certainly useless for anyone other than me.

These scripts create .bash_profile and .bashrc files. PATH, MANPATH,
INFOPATH, and PKG_CONFIG_PATH variables are set by searching the file
system for the relevant directories. The PS1 prompt is set, in part,
by parsing the git status command. I stole the git parsing from Brian
McFee [@functiontelechy](https://twitter.com/functiontelechy) years
ago.

Difference between .bash_profile and .bashrc
============================================
Bash login shells run ~/.bash_profile. Interactive, nonlogin shells
run ~/.bashrc.

Since nonlogin shells inherit their environment, exported environment
variables are put in .bash_profile and nonexported functions,
variables, and aliases in .bashrc. The end of .bash_profile sources
.bashrc.
