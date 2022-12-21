# Getting started with ALS

## Index
- [Installation](#Installation)
	- [Dependencies](#Dependencies)
	- [Install](#Install)
	- [Enable](#Enable)
- [Basic ALS syntax](#Basic-ALS-syntax)
	- [Rules](#Rules)
- [Sections](#Sections)
	- [Section patterns](#Section-patterns)
	- [Adding sections](#Adding-sections)
	- [Listing sections](#Listing-sections)
	- [Viewing the pattern of a section](#Viewing-the-pattern-of-a-section)
	- [Deleting sections](#Deleting-sections)
	- [Clearing sections](#Clearing-sections)
- [Alias management](#Alias-management)
	- [Adding aliases](#Adding-aliases)
	- [Hot-reloading](#Hot-reloading)
	- [Listing aliases](#Listing-aliases)
		- [All aliases](#All-aliases)
		- [Aliases from a specific section](#Aliases-from-a-specific-section)
	- [Deleting aliases](#Deleting-aliases)
- [Using `genalias2`](#Using-genalias2) (optional)
	- [What is it exactly?](#What-is-it-exactly)
	- [Global pattern](#Global-pattern)
	- [Usage from the commandline](#Usage-from-the-commandline)
		- [Interactive mode](#Interactive-mode)
		- [File mode](#File-mode)
	- [What happened to `genalias1`?](#What-happened-to-genalias1)

## Installation

### Dependencies
ALS depends only on core utilities. These should be already installed on most Linux distributions.

You **must** also have `sed` and `grep` installed on your systems but these are useful outside of ALS and you should have them anyway.

### Install
In order to install ALS, clone the repository and use the included installation script.

The installation script by default installs the scripts into `/usr/bin`. Invoke it with root permissions to install ALS:

```sh
git clone https://github.com/kaypiff/als
sudo ./install.sh
```

You can change the install directory by passing an argument to the script:

```sh
./install.sh ~/.local/bin
```

This may be used to avoid needing root privileges for the installation.
**Important:** Make sure the chosen directory is in your PATH or you won't be able to use the scripts.

### Enable
In order for the ALS aliases to work persistently in your shell of choice, you need to invoke this command:

```sh
echo "source ~/.local/share/als/output.sh" >> ~/.bashrc
aa !
```

Replace `.bashrc` with the appropriate file for your shell (eg. `.zshrc` for ZSH).

`aa !` is used to update the `output.sh` file so you avoid errors before any rules are added.

## Basic ALS syntax
We'll just touch the surface here. See [ALS Syntax](syntax.md) for a more detailed look.

### Rules
ALS rules follow the pattern `short -> long`.

- `short` - the alias name
- ` -> ` - an ALS 'verb' representing a rule. There **must** be whitespace surrounding it.
- `long` - the aliased thing (command, directory, ...)

#### Example
Let's look at an ALS rule:

```als
c -> clear
```

Its shell equivalent would be:

```sh
alias "c=clear"
```

This means your shell will execute `clear` whenever you type `c` into it. This example should be enough for you to be able to create your own ALS rules.

## Sections
Before you can add your first ALS rules, you need to add at least one section. Sections are represented with files in the `~/.local/share/als/sections` directory. These files contain your rules so they're necessary to be able to store them.

### Section patterns
Before you start creating sections, you need to learn about section patterns. These are templates used to reduce the amount of typing you need to do and to improve program interchangeability

The most basic pattern is `$$`. This will use the rules in the section *verbatim*. So,

```als
foo -> bar
```

Will be translated into:

```sh
alias "foo=bar"
```

Patterns can save you typing. They apply global transformations to all rules in the section. For example, the pattern `cd $$` can be used to quickly switch directories.
With this pattern, instead of writing:

```als
pr -> cd $HOME/programming
```

you only have to write:

```als
pr -> $HOME/programming
```

as the `cd` will be added there by the pattern.

Patterns can contain whole commands. For instance, I'm using a pattern: `cd ~/src/$$ && nvim config.h` to quickly edit my dwm, dmenu and dwmblocks configurations.
I only have to write: `swm -> dwm` and it expands to `alias "swm=cd ~/src/dwm && nvim config.h"`

Using section patterns effectively will improve your experience with ALS so keep them in mind.

### Adding sections
Sections can be created with the provided `asect` utility.
The general syntax is:

```sh
asect <name> <pattern>  # Create a section with the given name and pattern.
```

Using the name of an existing section will override its pattern with the new one.
You should wrap the pattern in single quotes to stop your shell from expanding the `$$` in it.

#### Example
```sh
asect dir 'cd $$'   # Adds a section 'dir' that uses 'cd' on every rule
```

The `asect` program creates a file in `~/.local/share/als/sections` and correctly applies the pattern to it by adding a line to `~/.local/share/als/main.als`.

### Listing sections
The list of currently available sections can be accessed by running `asect` with no arguments.

```sh
asect   # Echoes a list of available sections with their patterns.
```

The list is in the format: `<section name> '<pattern>'`, with each section in its own line.

Displaying patterns next to section names can be suppressed with:

```sh
asect -p    # Same as above but patterns aren't shown
```

### Viewing the pattern of a section
Instead of viewing all section patterns at once, you can view them individually by invoking:

```sh
asect <section> # Prints the pattern for a given section
```

### Deleting sections
If you want to delete a section and all of its rules, you can use the following:

```sh
asect <section> -d
```

**Note: the position of the arguments matters here.**

### Clearing sections
If you want to remove all rules from a section but keep the section intact, you can do:

```sh
asect <section> -c
```

**Again: you cannot swap `-c` with the section name - position matters**

## Alias management
After all, this is what ALS is all about. ALS aliases are represented as lines in their respective section files.

### Adding aliases
Make sure you've [created a section first](#Adding-sections). Then, you can start filling it with aliases.

```sh
aa <section> <rule> # Adds the rule to the given section
```

The rule is in the format `short -> long`, equivalent to `alias "short=long"`

#### Example
This will add a rule to the `dir` section to quickly go to the `~/programming` directory:

```sh
aa dir 'pr -> ~/programming'
```

### Hot-reloading
An alias is usable the next time you launch the shell. If you want to reload aliases with `aarel`, you can use ALS to set up a rule (assuming you've got a section named `custom` with the pattern `$$`):

```sh
aa custom 'aarel -> source ~/.local/share/als/output.sh'
```

You need to restart the shell after this command. This allows you to hot-reload aliases with the `aarel` command. Of course, you can change it to your liking.

### Listing aliases

#### All aliases
To view all aliases on your system, use `aa` with no arguments.

```
$ aa
pr -> cd ~/programming
c -> clear
v -> nvim .
```

Note that this method expands the aliases into their full form and displays them in ALS syntax.

#### Aliases from a specific section
Viewing aliases from a section is just as easy. Use `aa` with the section name.

```
$ aa dir
pr -> ~/programming
```

Note that this **does not** expand the aliases. The output is valid ALS syntax.

### Deleting aliases
Deleting a previously created alias only requires its short name:

```sh
ua <shortname>  # Unalias the alias with a given name
```

#### Example

```sh
aa dir 'pr -> ~/programming'    # pr is now aliases to the directory
ua pr                           # pr was removed from the list of aliases
aarel                           # reload aliases
```

## Using `genalias2`
Regular users can skip this section.

### What is it exactly?
`genalias2` is the backbone of the ALS system. It's the tool that transforms the easy-to-use ALS syntax into shell aliases and it also expands them. The `aa` utility is just a user-friendly interface for it. When you invoke `aa sect 'foo -> bar'`, the script appends a line to a file and uses `genalias2` to make it work in your shell. Even listing the aliases uses `genalias2` internally to expand them.

### Global pattern
`genalias2` parses [ALS syntax](syntax.md) and fits it into the given *global pattern*. The pattern is basically the desired output format. Every occurrence of `$$` in the pattern is replaced with the 'long' form of an alias and occurrences of `$<` are replaced with the 'short' form.

Given a global pattern of `$< = $$`, the following line:

```als
dog -> cat
```

will be replaced by `genalias2` with:

```als
dog = cat
```

**If no global pattern is supplied, `alias "$<=$$"` is used.**

### Usage from the commandline
`genalias2` can be used in two modes:

- **Interactive mode** - input is read from stdin and the results are printed to stdout
- **File mode** - input is read from a file and the results are printed to stdout

#### Interactive mode
Enter interactive mode by using `genalias2` with no arguments.
Supplying a different global pattern requires you to place it in the second position:

```sh
genalias2               # Interactive mode, default global pattern
genalias2 '' '$< = $$'  # Interactive mode, custom global pattern
```

Place each rule on a separate line. You can use both regular rules and transformations.
When you're done, press Ctrl+D to finish.

**Note:** `genalias2` prints the output only ***after*** sending EOF (Ctrl+D)

#### File mode
Pass a filename as the first argument to `genalias2` to use file mode.
A custom global pattern can be passed as the second argument:

```sh
genalias2 'aliases.als'             # File mode, default global pattern
genalias2 'aliases.als' '$< = $$'   # File mode, custom global pattern
```

### What happened to `genalias1`?
As the name suggests, `genalias2` is a 'sequel' to a program called `genalias`.
The first version was over 40 lines longer, about 2x slower and didn't support comments.
While it's technically usable, `genalias2` is superior in every way so we've decided
against including `genalias` in this package.
