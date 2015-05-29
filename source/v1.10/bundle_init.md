## bundle init

Generates a Gemfile into the current working directory.

``` bash
$ bundle init [--gemspec=FILE]
```
**Options:**

`--gemspec`: Use the specified `.gemspec` to create the `Gemfile`

Init generates a default `Gemfile` in the current working directory. When adding 
a `Gemfile` to a gem with a `.gemspec`, the **--gemspec** option will automatically 
add each dependency listed in the `.gemspec` file to the newly created `Gemfile`.
