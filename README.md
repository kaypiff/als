# ALS
Instant aliasing with a nicer syntax.

ALS allows you to write shell aliases (as with the `alias` command) with a more elegant syntax.
It saves you typing by introducing 'sections' - groups of aliases with a common pattern, like `cd $$` or `vim $$`.
It makes the process of writing persistent aliases much easier - you don't have to edit your .bashrc anymore!

[Proceed to installation/user guide](docs/getting-started.md)

## Why ALS?
Linux chads use aliases everywhere. From quick access to frequently used directories to shortening
long commands, aliases are extremely useful on the commandline. But keeping track of tens of aliases
in your config files can be daunting. If you've got 20 different aliases that use your code editor
but you decide to change it, you'll have to modify the 20 aliases separately.

ALS solves this by grouping your aliases into categories like 'editing' or 'directories' (these are user-defined)
and allowing you to change their template at any time. Switching all your aliases from `emacs` to `vim` is now
a single command.

ALS also doesn't require you to change your configuration files every time. It uses a .sh file containing your aliases
which is sourced by your shell and it automatically modifies the file as needed. Adding/removing persistent aliases
is just one command!

ALS also uses some syntactic sugar to make your aliases look pretty. Instead of writing:
```sh
alias "foo=bar"
```
you now only have to type
```als
foo -> bar
```

Isn't it neat?

## Programs included
- `asect` - ALS section manager
- `aa` - add alias
- `ua` - unalias
- `genalias2` - ALS engine

## Quick reference
- `aa` - view all aliases
- `aa <section>` - view aliases in a given section
- `aa <section> <rule>` - add a rule to a given section, replacing previous aliases
- `aa !` - regenerate shell aliases (use it after manual modification of .als files)
- `ua <short>` - unalias a rule by its short name
- `genalias2` - interactive mode, generate shell aliases from ALS
- `genalias2 <filename>` - generate shell aliases from an ALS file
- `genalias2 [filename] <pattern>` - generate using a desired pattern; if filename is empty, stdin is used
- `asect` - list all sections (in separate lines), use `echo $(asect)` or similar to join them.
- `asect <section>` - display the current configuration for a given section
- `asect <section> <pattern>` - create a new section or override an existing section, applying the given pattern
- `asect <section> -d` - delete a section and all of its rules
- `asect <section> -c` - remove all rules from a section

Refer to [Getting Started](docs/getting-started.md) for installation and a detailed usage guide.

## Contributions
Feel free to contribute code to this project. Just try not to overcomplicate stuff or pollute the project with features.
ALS should be an aliasing tool, not an operating system.

## Donate
If you'd like to support the project financially, below are our cryptocurrency addresses. We accept Monero and Dash.
Your support really makes a difference.

Monero
```
43yRNtkneyoRgVVGF6Lzhd6LjBKpVHBiWTdEzsWAxhwdaZndbuZX5QkcoVwB7M1r2JjNSWyNSS8QzKkck9XPyE2K3SAZWvv
```

Dash
```
XurVAyGUGboFZRyPwo8f7RLcgGVAEYMswN
```
