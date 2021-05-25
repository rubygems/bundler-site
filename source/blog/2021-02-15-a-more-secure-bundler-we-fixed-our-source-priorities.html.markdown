---

title: "A more secure bundler: We fixed our source priorities."
date: 2021-02-15 11:33 UTC
tags:
author: David Rodríguez
author_url: https://github.com/deivid-rodriguez/
category: security

---

> __NOTE__: Whereas the issue was initially fixed in bundler 2.2.10, it had to
> be reverted due to several problems caused by the initial approach. A proper
> fix was finally released with bundler 2.2.18.

## What happened?

Last week [an article about "Dependency
Confusion"](https://medium.com/@alex.birsan/dependency-confusion-4a5d60fec610)
hit the news, where a developer was able to make thousands of dollars on bug
bounty programs from big tech companies, by pushing libraries to public
repositories that ended up unintentionally being installed into these companies
servers.

The developer was able to expose (in a non-malicious way) a vulnerability
present in well-known dependency managers, where given a library name they will
end up preferring installing it from a public source rather than from a private
source. This is not secure because the name in the public source is controlled
by the first person claiming it, whereas the name in the private source is controlled
by the private source owner.

Unfortunately, Bundler had this vulnerability.

There's good news though:

## Things were safe on the rubygems.org side

The rubygems.org organization, in collaboration with
[diffend.io](https://diffend.io), have a pretty good malicious code detection
system. In fact, the only reason this developer was able to make all this money
by getting these gems installed in companies private servers is because our
system detected them, flagged them for us, and we determined them to be
non-malicious, and only for research purposes. If those gems had been malicious,
we wouldn't have allowed them.

Check out the [more detailed blog
post](https://mensfeld.pl/2021/02/rubygems-dependency-confusion-side-of-things/)
from our diffend.io friends about what happened in the rubygems.org side of
things, and how things were secure.

## The issue has been fixed in bundler 2.2.10

We have shipped bundler 2.2.10 with a fix, and now whenever you specify a block
source in your `Gemfile`, bundler will prioritize it when resolving direct
dependencies specified inside, and also transitive dependencies of those. So in
the following situation both `my-private-gem` and `my-another-private-gem` will
be picked up from `https://my-private-server`, even if someone pushes a higher
version with the same name to `rubygems.org`:

~~~ruby
# my-private-gem.gemspec
# ...
gem.dependency("my-another-private-gem")
~~~

~~~ruby
# Gemfile

source "https://rubygems.org"

source "https://my-private-server" do
  gem "my-private-gem"
end
~~~

Make sure you upgrade your bundler version either by running `gem install
bundler`, or by upgrading rubygems through `gem update --system` (which will
install bundler 2.2.10 as a default gem).

## Final notes

The bundler team had actually been aware of this issue for a while, but
unfortunately lacks resources to take care of everything we need to take care,
so the fix was postponed for too long. Maintaining the rubygems.org
infrastructure and its client libraries requires a big amount of work and we
barely manage to keep up with it. So, if your company really needs us to stay on
top of these issues, please consider funding
[RubyTogether](https://rubytogether.org/) ❤️.

That's all for today,

Happy bundling!

---

Deivid, André and the RubyGems team
