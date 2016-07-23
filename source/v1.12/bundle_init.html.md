## bundle init

Generates a Gemfile into the current working directory

    $ bundle init [--gemspec=FILE]


Options:

<code>--gemspec</code>: Use the specified .gemspec to create the Gemfile

Init generates a default Gemfile in the current working directory. When adding a
Gemfile to a gem with a gemspec, the --gemspec option will automatically add each
dependency listed in the gemspec file to the newly created Gemfile.
