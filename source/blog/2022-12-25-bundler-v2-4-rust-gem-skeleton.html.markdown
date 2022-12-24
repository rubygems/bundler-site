---
title: "Bundler v2.4: Generate gem skeleton with Rust extension"
date: 2022-12-25 20:00 UTC
tags:
author: Josef Šimánek
author_url: https://github.com/simi/
category: release
---

Do you think [dynamically typed](https://en.wikipedia.org/wiki/Dynamic_programming_language) [interpreted](https://en.wikipedia.org/wiki/Interpreter_(computing)) [Ruby language](https://www.ruby-lang.org/) and [statically typed](https://en.wikipedia.org/wiki/Type_system#Static_type_checking) [compiled](https://en.wikipedia.org/wiki/Compiled_language) [Rust language](https://www.rust-lang.org/) could be friends? Yes, they can! And actually, they are!

Officially it all started when [YJIT](https://github.com/ruby/ruby/blob/d5635dfe36588b04d3dd6065ab4e422f51629b11/doc/yjit/yjit.md) was [ported to Rust](https://bugs.ruby-lang.org/issues/18481) and [Ruby codebase](https://github.com/ruby/ruby) has officially [onboarded Rust code](https://github.com/ruby/ruby/tree/master/yjit/src). This friendship matured when RubyGems [3.3.11](https://rubygems.org/gems/rubygems-update/versions/3.3.11) (with a new [*Add cargo builder for rust extensions*](https://github.com/rubygems/rubygems/pull/5175) feature) [was released](https://blog.rubygems.org/2022/04/07/3.3.11-released.html) capable of compiling Rust-based extensions during gem installation process (similar to well-known C-based gem extensions like nokogiri, pg or puma).

And now, with Bundler 2.4, `bundle gem` skeleton generator can provide all the glue you need to start using Rust inside your gems thanks to the new `--ext=rust` parameter!

## What's new?

Thanks to new parameter it is possible to generate simple Rust-based gem extension.

*Notice I already have bundle `gem command` configured. Your output can differ. When running `bundle gem` for the first time, it will interactively ask you few questions.*

~~~
$ bundle gem --ext=rust hello_rust
Creating gem 'hello_rust'...
MIT License enabled in config
Initializing git repo in /home/retro/code/hello_rust
      create  hello_rust/Gemfile
      create  hello_rust/lib/hello_rust.rb
      create  hello_rust/lib/hello_rust/version.rb
      create  hello_rust/sig/hello_rust.rbs
      create  hello_rust/hello_rust.gemspec
      create  hello_rust/Rakefile
      create  hello_rust/README.md
      create  hello_rust/bin/console
      create  hello_rust/bin/setup
      create  hello_rust/.gitignore
      create  hello_rust/test/test_helper.rb
      create  hello_rust/test/test_hello_rust.rb
      create  hello_rust/LICENSE.txt
      create  hello_rust/Cargo.toml
      create  hello_rust/ext/hello_rust/Cargo.toml
      create  hello_rust/ext/hello_rust/extconf.rb
      create  hello_rust/ext/hello_rust/src/lib.rs
Gem 'hello_rust' was successfully created. For more information on making a RubyGem visit https://bundler.io/guides/creating_gem.html
~~~

For Rust-based extension last 4 entries are interesting.

- `hello_rust/Cargo.toml`
    - Top-level `Cargo.toml` is just pointing to "nested" `Cargo.toml` in `ext` folder.
    - It is useful to be able to run all `cargo` commands in top-level directory (next to `bundle`, `gem`, ...).
    - It is also useful for your IDE to be able to recognize there is Rust code in this folder, but not in standard path for Rust crate.
- `hello_rust/ext/hello_rust/Cargo.toml`
    - Actual `Cargo.toml` as known from Rust crates. It includes package metadata, configuration and dependencies. You can think of this file as a "gemspec for Rust packages".
- `hello_rust/ext/hello_rust/extconf.rb`
    - Config file responsible for configuration of compilation of your Rust code in Ruby world (for example during gem installation).
    - Currently based on [rb_sys gem](https://github.com/oxidize-rb/rb-sys/tree/main/gem#the-rb_sys-gem). Check [project README](https://github.com/oxidize-rb/rb-sys/tree/main/gem#create_rust_makefile) for more info.
- `hello_rust/ext/hello_rust/src/lib.rs`
    - Yes, the holy grail of Rust-based extension - the Rust code!

## Hello from Rust!

Generated `hello_rust/ext/hello_rust/src/lib.rs` contains hello world example method defined at base class of extension. In my case it is `HelloRust#hello` with 1 string argument returning string as well. It is using [magnus](https://github.com/matsadler/magnus) Rust bindings to Ruby for super smooth developer experience.

~~~rust
# hello_rust/ext/hello_rust/src/lib.rs
use magnus::{define_module, function, prelude::*, Error};

fn hello(subject: String) -> String {
    format!("Hello from Rust, {}!", subject)
}

#[magnus::init]
fn init() -> Result<(), Error> {
    let module = define_module("HelloRust")?;
    module.define_singleton_method("hello", function!(hello, 1))?;
    Ok(())
}
~~~

That is equivalent to following Ruby code, including some boilerplate code, to enable Rust extension to communicate with Ruby.

~~~ruby
module HelloRust
  def self.hello(subject)
    "Hello from Rust, #{subject}!"
  end
end
~~~

## Let's compile and run some Rust!

To be able to test this boilerplate code, you need to run `bundle install` first (to install all Ruby dependencies) followed by `bundle exec rake compile` compiling Rust code.

*Notice generated gemspec is not valid by default and running `bundle install` can break. In that case it is needed to update gemspec first and replace all TODO values with some real ones.*

~~~
$ bundle install
Fetching gem metadata from https://rubygems.org/.
Resolving dependencies...
Using rake 13.0.6
Using bundler 2.4.0
Using hello_rust 0.1.0 from source at `.`
Using minitest 5.16.3
Using rake-compiler 1.2.1
Using rb_sys 0.9.52
Bundle complete! 5 Gemfile dependencies, 6 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
~~~

At this stage, everything is ready to compile Rust code and glue it with Ruby.

*You need to have Rust already installed on your system. See [rustup](https://rustup.rs/) for simple installation experience.*

~~~
$ bundle exec rake compile
mkdir -p tmp/x86_64-linux/hello_rust/3.1.2                                                                                                                                             
cd tmp/x86_64-linux/hello_rust/3.1.2                                                                                                                                                   
/home/retro/.rubies/ruby-3.1.2/bin/ruby -I. -r.rake-compiler-siteconf.rb ../../../../ext/hello_rust/extconf.rb             
cd -                                           
cd tmp/x86_64-linux/hello_rust/3.1.2
/usr/bin/gmake
generating target/release/libhello_rust.so (release)
cargo rustc --target-dir target --manifest-path ../../../../ext/hello_rust/Cargo.toml --lib --release -- -C linker=gcc -L native=/home/retro/.rubies/ruby-3.1.2/lib -C link-arg=-lm
    Updating crates.io index
... shortened
   Compiling magnus-macros v0.2.0
   Compiling rb-sys-build v0.9.52
   Compiling rb-sys v0.9.52
   Compiling hello_rust v0.1.0 (/home/retro/code/hello_rust/ext/hello_rust)
    Finished release [optimized] target(s) in 1m 03s
cd -
mkdir -p tmp/x86_64-linux/stage/lib/hello_rust
/usr/bin/gmake install target_prefix=
generating target/release/libhello_rust.so (release)
cargo rustc --target-dir target --manifest-path ../../../../ext/hello_rust/Cargo.toml --lib --release -- -C linker=gcc -L native=/home/retro/.rubies/ruby-3.1.2/lib -C link-arg=-lm
    Finished release [optimized] target(s) in 0.09s
installing hello_rust.so to /home/retro/code/hello_rust/lib/hello_rust
/usr/bin/install -c -m 0755 hello_rust.so /home/retro/code//hello_rust/lib/hello_rust
cp tmp/x86_64-linux/hello_rust/3.1.2/hello_rust.so tmp/x86_64-linux/stage/lib/hello_rust/hello_rust.so
~~~

And finally, it is possible to call `hello` method defined in Rust returning string and print it to the console.

~~~
$ bundle exec ruby -rhello_rust -e 'puts HelloRust.hello("Josef")'
"Hello from Rust, Josef!"
~~~

*Feel free to try to break this extension. For example you can try to pass different type of argument (like number or symbol). [magnus](https://github.com/matsadler/magnus) is doing great job [automatically coverting](https://github.com/matsadler/magnus#defining-methods) all those mistakes with friendly error messages.*

## Summary

Starting Bundler 2.4, you can generate gem skeleton with all boilerplate code needed to start using Rust. But it is not only about your custom Rust code you can easily integrate into gems now. Thanks to integration with [cargo](https://doc.rust-lang.org/cargo/) (Rust package manager) you can use any of [Rust crates](https://crates.io/) available. Rust ecosystem is well known for highly optimized and memory safe libraries. Thanks to [magnus](https://github.com/matsadler/magnus) and `bundle gem` command, it is possible to glue those Rust libraries into Ruby world smoothly. Sky is the limit ;-)

*To see real-life example how powerful could be Rust for data processing, I recommend to check [kirby project](https://github.com/rubytogether/kirby) parsing logs for [rubygems.org](http://rubygems.org/).*
