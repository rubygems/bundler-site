## bundle console

Start an interactive Ruby console session in the context of the current bundle.

``` bash
$ bundle console [GROUP]
```

`bundle console` uses `irb` by default. Alternatives like Pry and Ripl can be used with bundle console by adjusting the <code>console</code> Bundler setting. Also make sure that `pry` or `ripl` is in your Gemfile.

``` bash
$ bundle config console pry
$ bundle console
[1] pry(main)>
```
