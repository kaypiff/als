# ALS Syntax
A small document on ALS syntax.

## Rule
- A rule is a single statement in ALS.
- A rule is defined by the following pattern: `short -> long`
        - The rule above means: expand `short` into `long`.
        - It's equivalent to `alias "short=long"`
## Transformation
- A transformation is an action performed on an ALS file.
- It's defined by the following pattern: `filename --> pattern`
        - For each line of `filename`, transform it according to the pattern.
        - Every occurrence of `$$` in the pattern is replaced with the `long` part of the rule
        - Example: `./dir.als --> cd $$`
                - Transforms `foo -> bar` into `foo -> cd bar`
- All transformations are recursive. The output of one transformation becomes the `$$` of the ones above it on the recursion stack.
## Global pattern
- The global pattern is the output format specified when invoking `genalias2`
- The default pattern is `alias "$<=$$"`, which generates standard shell aliases.
- Any occurrence of `$<` in the pattern is replaced with the `short` part of the rule
- Any occurrence of `$$` in the pattern is replaced with the `long` part of the rule
## Comments & whitespace
- Comments in ALS begin with `#`
- Comments can be placed anywhere in the file, including after statements
- An ALS statement **must** be contained in a single line
- Empty lines and lines containing only whitespace are ignored.
- **IMPORTANT:** Whitespace is ***required*** around the arrows (`->` and `-->`)
        - `foo -> bar` is fine, same as `foo           ->     bar`, but `foo-> bar` is not, same with `foo ->bar` and `foo-->bar`
        - Both spaces and tabs can be used here
        - Additional whitespace (like alignment) is ignored
