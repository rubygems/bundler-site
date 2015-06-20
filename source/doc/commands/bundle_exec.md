## bundle exec

> Run a command in context of the bundle.

~~~
$ bundle exec [--keep-file-descriptors] <command>
~~~

**Options:**

`--keep-file-descriptors`: For Ruby versions less than 2.0, keeps non-standard file descriptors on `Kernel#exec`

This command executes the command, making all gems specified in the `Gemfile(5)` available to `require` in Ruby programs.

Essentially, if you would normally have run something like `rspec spec/my_spec.rb`, and you want to use the gems specified
in the `Gemfile` and installed via `bundle install`, you should run `bundle exec rspec spec/my_spec.rb`.

Note that `bundle exec` does not require that an executable is available on your shell's `$PATH`.
