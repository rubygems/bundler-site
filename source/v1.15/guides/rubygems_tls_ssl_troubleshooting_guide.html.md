---
title: RubyGems.org SSL/TLS Troubleshooting Guide
---

# RubyGems.org SSL/TLS Troubleshooting Guide

If you’ve experienced issues related to SSL/TLS when attempting to download gems from RubyGems.org you’ve come to the right place. In this guide, we’ll explain how these issues come about and how to solve them.

## Overview

When using Bundler an error such as

    $ bundle install

    Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=error: certificate verify failed

Or

    $ bundle install

    Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=SSLv2/v3 read server

mean that Bundler was unable to establish a SSL/TLS connection to the RubyGems.org servers which is required to let Bundler download gems.

## Why Does This Error Occur?

There are 2 main reasons why this error will occur. You're running a version Ruby that does not support the minimum requirements to allow Bundler to connect to RubyGems.org using SSL/TLS.

The other reason is that you may have an old version of rubygems or an old certificate authority bundle.

We'll explain each problem and the steps you can take to solve it.

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

