## bundle gem

Creates a skeleton for creating a rubygem.

```
$ bundle gem GEM [-b, --bin] [--test=TESTFRAMEWORK] [--edit=TEXTEDITOR] [--ext]
```

**Options:**

`-b, --bin`: Generate a binary for your library.

`--edit`: Opens generated gemspec with specified or default text editor to set
`$BUNDLER_EDITOR`, `$EDITOR` or `$VISUAL` env variables.

`--ext`: Generate a skeleton for a C-extension.

`--test`: Generate a test directory for your library: `rspec` is the default,
but `minitest` is also supported.
