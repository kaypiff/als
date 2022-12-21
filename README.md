# ALS
Instant aliasing with a nicer syntax.

ALS allows you to write shell aliases (as with the `alias` command) with a more elegant syntax.
It saves you typing by introducing 'sections' - groups of aliases with a common pattern, like `cd $$` or `vim $$`.
It makes the process of writing persistent aliases much easier - you don't have to edit your .bashrc anymore!

## Programs included
- `asect` - ALS section manager
- `aa` - add alias
- `ua` - unalias
- `genalias2` - ALS engine

## Quick reference
- `aa` - view all aliases
- `aa <section>` - view aliases in a given section
- `aa <section> <rule>` - add a rule to a given section, replacing previous aliases (uses `ua`)
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
