## bundle viz

Generates a visual dependency graph

    $ bundle viz [--file=FILE] [--format=FORMAT] [--requirements] [--version]
                 [--without=GROUP GROUP]
    
Options:

<code>--file or -f</code>: The name to use for the generated file. see format option

<code>--format or -F</code>: This is output format option. Supported format is png, jpg, svg, dot ...

<code>--requirements or -r</code>: Set to show the version of each required dependency.

<code>--version or -v</code>: Set to show each gem version.

<code>--without</code>: Exclude gems that are part of the specified named group.

<a href="/groups.html" class="btn btn-primary">Learn More: Groups</a>

Viz generates a PNG file of the current Gemfile as a dependency graph.
Viz requires the ruby-graphviz gem (and its dependencies).
The associated gems must also be installed via 'bundle install'.
