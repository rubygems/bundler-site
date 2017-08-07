---
title: RubyGems.org SSL Troubleshooting Guide
---

# RubyGems.org SSL Troubleshooting Guide

If you're trying to install gems with Bundler or RubyGems, but seeing an error that includes `SSL_connect`, keep reading. This guide will explain the underlying reasons for common errors, and suggest possible ways to fix them.

If you're not interested in the reasons, and just want to get things fixed as quickly as possible, you can jump straight to [solutions for SSL issues]().

## Table of Contents

  - **The Problems**
    - [Why am I seeing `certificate verify failed`?](#why-am-i-seeing--code-certificate-verify-failed--code--)
      - [Why does this matter?]()
      - [How Ruby uses CA certificates]()
      - [Possible solutions for certificate errors]()
    - [Why am I seeing `read server hello A`?](#read-server)
      - [SSL and TLS protocol versions]()
      - [TLS 1.0 and 1.1 are deprecated]()
      - [Possible solutions for protocol errors]()
  - **The Solutions**
    - [Automated SSL check]()
    - [Updating Bundler]()
    - [Updating RubyGems]()
    - [Updating CA certificates]()
      - [Installing new RubyGems certificates]()
      - [Installing new OS certificates]()
    - [Reinstalling Ruby]()
      - [Installed with `rvm`]()
      - [Installed with `ruby-build` or `rbenv install`]()
      - [Installed with `ruby-installer`]()
      - [Ruby was packaged for your OS]()
        - [macOS: Built-in Ruby]()
        - [macOS: Installed with Homebrew]()
        - [Debian or Ubuntu: Installed with `apt-get`]()
        - [Fedora: Installed with `dnf`]()
        - [RHEL or CentOS: Installed with `yum`]()
        - [Windows: Installed with Ruby Installer]()
  - **Additional help**
    - [Another automated SSL check]()
    - [Still having trouble?]()
    - [Contributing to this guide]()

## The Problems

### Why am I seeing `certificate verify failed`?

This error happens when your computer is missing a file that it needs to verify that the server behind RubyGems.org is the correct one.
The latest version of RubyGems should fix this problem, so we recommend updating to the current version. To tell RubyGems to update itself to the latest version, run `gem update --system`. If that doesn’t work, try the manual update process below.
(What do we mean by updating “should fix this problem”? Review our article on how SSL works with RubyGems to gain a better understanding of the underlying problems.


## Common SSL exceptions

When running `bundle install` or `gem install`, there are two different SSL-related exceptions that frequently crop up.

The first error means that Ruby isn't able to verify that it is talking to the true RubyGems.org. Rather than possibly installing gems from a malicious server pretending to be RubyGems.org, Ruby raises an exception to let you know about the problem. That exception looks like this:

    Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=error: certificate verify failed

The other issue occurs if your version of OpenSSL is very old, and Ruby is not able to use it to connect to the RubyGems.org servers securely. In that case, you'll see an error like this one:

    Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=SSLv2/v3 read server

If you want to know more about why these errors occurr, keep reading. If you're just looking for a fix, [jump straight to the solutions](#solutions).

# How Bundler uses SSL certificates

## What are these certificates?

All web browsers come with a certificate authority (CA) bundle. These are cryptographic certificates provided by the companies that sell SSL certificates (like Verisign, Globalsign, and others). Using those "root” keys/certificates (they’re called root keys because they are the keys from which many other companies and websites derive their SSL certificates), web browsers “know” they can trust the SSL certificate being given to them by a particular website, such as RubyGems.org.

Occasionally, new companies are added to the CA bundle, or existing companies have their certificates expire and need to distribute new ones. For most websites, this isn't a huge problem, because web browsers regularly update their CA bundle as part of general browser updates.

## How Ruby uses CA bundles

The SSL certificate used by RubyGems.org descends from a new-ish root certificate. Ruby (and therefore RubyGems and Bundler) does not have a regularly updated CA bundle to use when contacting websites. Usually, Ruby uses a CA bundle provided by the operating system (OS). On older OSes, this CA bundle can be really old—as in a decade old. Since a CA bundle that old can’t verify the (new-ish) certificate for RubyGems.org, you might see the error in question: `certificate verify failed`.

Further complicating things, an otherwise unrelated change 18-24 months ago lead to a new SSL certificate being issued for RubyGems.org. This meant the “root” certificate that needed to verify connections changed. So even if you’d previously upgraded RubyGems/Bundler in order to fix the SSL problem, you would need to upgrade again—this time to an even newer version with even newer certificates.

## Fixing SSL certificate errors

There are two ways to supply the certificate Ruby needs to verify RubyGems.org:

1. Update to the latest versions of RubyGems/Bundler, which include the relevant certificates in the gem and ask Ruby to use them, or
2. You can update the certificates provided by your OS. This lets Ruby use those certificates to successfully verify the connection.

You can upgrade Bundler by running `gem install bundler`, and you can upgrade RubyGems by running `gem update --system`. If you're still having trouble even after running those commands, check out our [SSL Troubleshooting Guide][1] for more help.


## SSL/TLS minimum requirements

RubyGems.org uses a 3rd party CDN provider called [Fastly](https://www.fastly.com/), which lets users all around the world download gems really quickly.

Last year, Fastly announced it will deprecate TLS versions 1.0 and 1.1 due to a mandate published by the PCI Security Standard Council. ([Read more about this in Fastly’s blog post.](https://www.fastly.com/blog/phase-two-our-tls-10-and-11-deprecation-plan))

As a result, RubyGems.org will require TLSv1.2 at minimum starting January 2018. This means RubyGems.org and the `gem` command will no longer support versions of Ruby and OpenSSL that are do not have support of TLS 1.2.

### Troubleshooting instructions

You can check if your current ruby environment supports TLS 1.2. Execute the following command in your terminal:

    ruby -ropenssl -e 'puts "TLS v1.2 support: #{OpenSSL::SSL::SSLContext::METHODS.include?(:TLSv1_2)}"'

This will print a result saying if ruby supports TLS 1.2

    TLS v1.2 support: true

If the result is `false` then you will need to update both Ruby and OpenSSL.

### Solutions

The easiest and recommended solution is to update Ruby and OpenSSL to a recent version which supports TLS 1.2. Refer to your system's package manager on updating Ruby and OpenSSL.

#### Reinstalling from rbenv/ruby-build
Follow the instructions outlined in the [Updating and Troubleshooting ruby-build guide](https://github.com/rbenv/ruby-build/wiki#updating-ruby-build) by rbenv.

#### macOS: Upgrading built-in Ruby
Note: macOS 10.13 High Sierra comes with default Ruby that is compatible with TLSv1.2.

To check your current macOS version, go to the Apple menu and choose “About This Mac”. If you see anything other than “macOS High Sierra”, you will need to upgrade to the newest macOS (or else install a newer version of Ruby with Homebrew by following the next set of instructions after these).

To upgrade to High Sierra:
* Open the App Store application
* Choose the “Updates” tab
* Click the “Install” button for “macOS High Sierra”

#### macOS: Upgrading Ruby with Homebrew
To install a newer version of Ruby with Homebrew, first make sure Homebrew is installed. If the brew command is not present, follow the installation instructions at [https://brew.sh](https://brew.sh) and then come back to these steps.

    $ brew install ruby

If Ruby is already installed

    $ brew upgrade ruby

to upgrade to the latest version.

#### Debian/Ubuntu: Upgrading Ruby with apt

To remove Ruby with apt, you’ll need to check which versions of Ruby you have installed. apt installs Ruby v2.3.1.

To uninstall, [follow the directions listed here](https://stackoverflow.com/a/22753859) (These instructions work for both Ubuntu and Debian).

Once you’ve successfully uninstalled Ruby, reinstall it by running:

    $ sudo apt-get install ruby

#### Fedora: Upgrading Ruby with dnf
The newest versions of Fedora use `dnf` as its package manager, but older versions use `yum` instead. If you see the error message `dnf: command not found`, replace the dnf in these instructions with `yum`.

First, uninstall Ruby by running:

    $ dnf remove ruby

And then reinstall (this command will install Ruby 2.3):

    $ dnf install ruby

#### RHEL/CentOS: Upgrading Ruby with yum
Follow these directions for [upgrading Ruby on CentOS](http://ask.xmodulo.com/upgrade-ruby-centos.html) (They also include instructions for troubleshooting OpenSSL).

#### Windows: Reinstalling with Ruby Installer
From the Control Panel, find the Ruby installer in “Programs”. Click on the folder, and click again on “Uninstall Ruby”.
Reinstall by downloading Ruby and the Ruby DevKit at [RubyInstaller](https://rubyinstaller.org/downloads/).

### Certificate Verify Failed

This error occurs when Bundler/RubyGems was unable to verify the SSl/TLS certificate on RubyGems.org. This is most likely an issue with your Ruby environment than RubyGems.org. There are several ways the certificate could not be verified such as:

* The clock on your machine is not up to date
* old or missing certificate authority bundles

#### Solutions

There are numerous approaches to fixing this problem, it's recommended to read each solution and determine which is the best suited for your situation.

##### Make sure your clock is current

Part of verifying a SSL certificate is checking when the certificate was issued and when it expires. So having the correct time on your system is up to date.

Most operating systems like Windows and MacOS will automatically update the clock to the current time for you. For Unix type systems you may need to check your running the NTP daemon.

* [How To Set Up Time Synchronization on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-time-synchronization-on-ubuntu-16-04)
* [Clock Synchronization with NTP on FreeBSD](https://www.freebsd.org/doc/handbook/network-ntp.html)

##### Old or missing certificate authority bundle

A certificate authority bundle is a set of certificates that have been signed by Certificate Authorities that is installed on your system. These certificates validate that a signed certificate a website like RubyGems.org for example, was validated and signed by a trusted Certificate Authority.

Operating like MacOS and Windows distribute a certificate bundle with each release, but on Unix systems one may have to be installed through your package manager.

Refer to your systems documentation on installing an up to date certificate bundle.

##### Update RubyGems
RubyGems ships with a set of certificates that lets Bundler download gems from RubyGems.org even without the certificate authority bundle. Overtime these certificates do expire so we recommend to keep RubyGems up to date.

    $ gem update --system

##### Manually installing the trust certificate

If you’re unable to update RubyGems, you can manually add the certificate RubyGems needs. If you have a version of RubyGems new enough (version 2.1.x and above) that can use those “vendored” certificates—and you install the certificate successfully—it will work without upgrading the RubyGems version.

Warning: These instructions will only add new certs; Ruby will be left untouched. To ensure your Ruby version can use TLSv1.2, run the snippet again. If not, follow a different set of instructions in this guide for upgrading Ruby as well.


**Step 1: Get the new trust certificate**

Download the `.pem` file from this link: [GlobalSignRootCA.pem](https://raw.githubusercontent.com/rubygems/rubygems/master/lib/rubygems/ssl_certs/index.rubygems.org/GlobalSignRootCA.pem)

Then, find the downloaded file, and check to make sure the filename ends in `.pem`. (Some browsers will change the extension to `.txt`, which will prevent this from working. So it’s important to make sure the file you downloaded ends in a `.pem` extension.)

**Step 2: Locate RubyGems certificate directory in your installation**

Next, you’ll want to find the directory where you installed Ruby in order to add the .pem  file there.

**On Windows**

Open your command line and type in:

    C:\>gem which rubygems

You’ll see output like this:

    C:/Ruby21/lib/ruby/2.1.0/rubygems.rb

To  open a window showing the directory we need to find, enter the path part up to the file extension in the same window (but using backslashes instead). For example, based on the output above, you would run this command.

    C:\>start C:\Ruby21\lib\ruby\2.1.0\rubygems

This will open an Explorer window, showing the directory RubyGems is installed into. .

**On macOS**

Open Terminal and run this command:

    $ gem which rubygems

You’ll see output like this:

    /opt/rubies/2.4.1/lib/ruby/2.4.0/rubygems.rb

To open a window showing the directory we need to find, use the `open` command on that output without the “.rb” on the end, like this:

    $ open /opt/rubies/2.4.1/lib/ruby/2.4.0/rubygems

A Finder window will open showing the directory that RubyGems is installed into.

**Step 3: Copy new trust certificate**

In the window, open the ssl_certs directory and drag your `.pem` file into it. It will be listed with other files like `AddTrustExternalCARoot.pem`.

Once you’ve done this, it should be possible to follow the directions at the very top to automatically update RubyGems. Visit the Updating RubyGems section for step-by-step instructions. If that doesn’t work, keep following this guide.

#### Reinstalling RVM

_Try this solution if updating SSL certificates with RVM doesn’t work._

If Ruby which was installed with RVM can’t find the correct certificates even after they have been updated, you might be able to fix it by reinstalling RVM and then reinstalling your Ruby version.

Run these commands to remove RVM and reinstall it:

    $ rvm implode

    $ \curl -sSL https://get.rvm.io | bash -s stable

Then, reinstall Ruby while telling RVM that you don’t want to use precompiled binaries. (Unfortunately, this will take longer, but it will hopefully fix the SSL problem.) This command will install Ruby 2.2.3. Adjust the command to install the version(s) of Ruby that you need.

    $ rvm install 2.2.3 --disable-binary

**macOS: Reinstalling RVM with OpenSSL from Homebrew **

This solution might work when the version of OpenSSL installed with Homebrew interferes with Ruby’s ability to find the correct certificates. Sometimes, uninstalling everything and starting again from scratch is enough to fix things.

First, you’ll want to remove RVM. You can do that by running this command:

    $ rvm implode

Next, you’ll want to remove OpenSSL from Homebrew. (Using --force ensures that you remove all versions of OpenSSL you might have):

    $ brew uninstall openssl --force

Now, you can reinstall RVM, following the instructions from the previous step.

**macOS: Updating SSL certs using RVM**

This lets you to download a new CA bundle that can verify RubyGems.org, allowing Ruby to use that new bundle.

Run the following in your command line to update all of your SSL certs:

    $ rvm osx-ssl-certs update all

---

Hopefully, these troubleshooting steps were able to help you resolve your problems with installing gems.

If you’re still having trouble, please visit the [Bundler issue tracker](https://github.com/rubygems/rubygems/issues) and [create a new issue](https://github.com/rubygems/rubygems/issues/new). Please include:

1. The command(s) you are running

2. The output from that command

3. The output from running `gem env`

4. Which troubleshooting steps you have tried so far

