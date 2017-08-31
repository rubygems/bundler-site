---
title: RubyGems.org SSL Troubleshooting Guide
---

# RubyGems.org SSL Troubleshooting Guide

If you're trying to install gems with Bundler or RubyGems, but seeing an error that includes `SSL_connect`, keep reading. This guide will explain the underlying reasons for common errors, and suggest possible ways to fix them.

If you're not interested in the reasons, and just want to get things fixed as quickly as possible, you can jump straight to [solutions for SSL issues]().

## Table of Contents

  - **The Problems**
    - [Why am I seeing `certificate verify failed`?][verify-failed]
      - [What are these certificates?][what-are-certificates]
      - [How Ruby uses CA certificates][how-ruby-uses-ca-certs]
      - [Troubleshooting certificate errors][troubleshooting-certificate-errors]
    - [Why am I seeing `read server hello A`?][read-server]
      - [SSL and TLS protocol versions][ssl-and-tls-protocol-versions]
      - [TLS 1.0 and 1.1 are deprecated][tls-10-and-11-are-deprecated]
      - [Troubleshooting protocol errors][troubleshooting-protocol-errors]
  - **The Solutions**
    - [Automated SSL check][ssl-check]
    - [Updating Bundler][update-bundler]
    - [Updating RubyGems][update-rubygems]
    - [Updating CA certificates][updating-ca-certificates]
      - [Installing new RubyGems certificates][update-rubygems-certs]
      - [Installing new OS certificates][update-os-certs]
    - [Reinstalling Ruby from version managers]()
      - [Installed with `rvm`]()
      - [Installed with `ruby-build` or `rbenv install`]()
      - [Installed with `ruby-installer`]()
    - [Reinstalling Ruby from OS package managers]()
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
[verify-failed]: #why-am-i-seeing--code-certificate-verify-failed--code--

This error happens when your computer is missing a file that it needs to verify that the server behind RubyGems.org is the correct one.
The latest version of RubyGems should fix this problem, so we recommend updating to the current version. To tell RubyGems to update itself to the latest version, run `gem update --system`. If that doesn’t work, try the manual update process below. (What do we mean by updating “should fix this problem”? Review our article on how SSL works with RubyGems to gain a better understanding of the underlying problems.

#### What are these certificates?
[what-are-certificates]: #what-are-these-certificates-

Anytime your computer is talking to a server using HTTPS, it uses an _SSL certificate_ as part of that connection. The certificate allows your computer to know that it is talking to the real server for a domain, and allows it to make sure that your computer and that server can communicate completely privately, without any other computer knowing what is sent back and forth.

To know if the certificate for RubyGems.org is correct, your computer consults another certificate from a Certificate Authority (CA). The CA certificate bundle includes certificates from every company that provides SSL certificates for servers, like Verisign, Globalsign, and many others.

Each CA has a "root” certificate that they use to verify other certificates. The CA certificates are called "root" because they sign other certificates that sign yet other certificates, and a graph of the certificates would look like a tree, with the "root" certificates at the root of the tree. Your computer will use its built-in CA bundle of many root certificates to know whether to trust an SSL certificate provided by a particular website, such as RubyGems.org.

Occasionally, new companies are added to the CA bundle, or existing companies have their certificates expire and need to distribute new ones. For most websites, this isn't a huge problem, because web browsers regularly update their CA bundle as part of general browser updates.

#### How Ruby uses CA certificates
[how-ruby-uses-ca-certs]: #how-ruby-uses-ca-certificates

The SSL certificate used by RubyGems.org descends from a new-ish root certificate. Ruby (and therefore RubyGems and Bundler) does not have a regularly updated CA bundle to use when contacting websites. Usually, Ruby uses a CA bundle provided by the operating system (OS). On older OSes, this CA bundle can be really old—as in a decade old. Since a CA bundle that old can’t verify the (new-ish) certificate for RubyGems.org, you might see the error in question: `certificate verify failed`.

Further complicating things, an otherwise unrelated change 18-24 months ago lead to a new SSL certificate being issued for RubyGems.org. This meant the “root” certificate that needed to verify connections changed. So even if you’d previously upgraded RubyGems/Bundler in order to fix the SSL problem, you would need to upgrade again—this time to an even newer version with even newer certificates.

#### Troubleshooting certificate errors
[troubleshooting-certificate-errors]: #troubleshooting-certificate-errors

Start by [running the automatic SSL check][ssl-check], and follow the instructions. You might need to [update Bundler][update-bundler], [update RubyGems][update-rubygems], [manually update RubyGems certificates][update-rubygems-certs], or perhaps even [install new OS certificates][update-os-certs].

### Why am I seeing `read server hello A`?
[read-server]: #why-am-i-seeing--code-read-server-hello-a--code--

This error means that your machine was unable to establish a secure connection to RubyGems.org. The most common cause for that problem is a Ruby that uses an old version of OpenSSL. OpenSSL 1.0.1, released March 12, 2012, is the minimum version required to connect to RubyGems.org, starting January 1, 2018.

To understand why that version is required, keep reading. To see instructions on how to update OpenSSL and/or Ruby to fix the problem, skip to the [troubleshooting section][troubleshooting-protocol-errors].

#### SSL and TLS protocol versions
[ssl-and-tls-protocol-versions]: #ssl-and-tls-protocol-versions

Secure connections on the internet use [HTTPS](https://en.wikipedia.org/wiki/HTTPS), the secure version of HTTP. That security was originally provided by SSL, an acronym for Secure Sockets Layer. Over time, researchers discovered flaws in SSL, and network developers responded with changes and fixes. After SSL 3.0, it was replaced by TLS: [Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security).

Over time, TLS was also revised. TLS version 1.2, originally defined in 2011, and supported by OpenSSL starting in 2012, is the current standard. In 2017, every version of SSL and TLS older than TLS 1.2 has been found to have critical flaws that can be exploited by a determined or knowledable adversary. As a result, security best practices suggest actively blocking all versions of SSL, as well as TLS versions 1.0 and 1.1.

#### TLS 1.0 and 1.1 are deprecated
[tls-10-and-11-are-deprecated]: #tls-10-and-11-are-deprecated

RubyGems.org is served by a content delivery network, [Fastly](https://www.fastly.com/). By using Fastly, RubyGems.org is able to provide dramatically faster service, answering requests around the world from a nearby data center instead of answering every request from the US.

In 2016, Fastly announced it will deprecate TLS versions 1.0 and 1.1 due to a mandate published by the PCI Security Standard Council. ([Read more about this in Fastly’s blog post.](https://www.fastly.com/blog/phase-two-our-tls-10-and-11-deprecation-plan))

Following the recommendations of the PCI Security Standard Council, RubyGems.org will require TLSv1.2 starting January 2018. This means RubyGems.org and the `gem` command will only work on a version of Ruby with OpenSSL 1.0.1 or newer, with support for TLSv1.2.

#### Troubleshooting protocol errors
[troubleshooting-protocol-errors]: #troubleshooting-protocol-errors

To troubleshoot protocol connection errors, start by [running the automatic SSL check][ssl-check], and follow the instructions. You might need to [update Bundler][update-bundler], [update RubyGems][update-rubygems], or even [reinstall ruby][reinstall-ruby].


## The Solutions

### Automated SSL check
[ssl-check]: #automated-ssl-check
### Updating Bundler
[update-bundler]: #updating-bundler
### Updating RubyGems
[update-rubygems]: #updating-rubygems
### Updating CA certificates
[updating-ca-certificates]: #updating-ca-certificates
#### Installing new RubyGems certificates
[update-rubygems-certs]: #installing-new-rubygems-certificates
#### Installing new OS certificates
[update-os-certs]: #installing-new-os-certificates
### Reinstalling Ruby from version managers
[reinstall-ruby]: #reinstalling-ruby-from-version-managers
#### Installed with `rvm`
#### Installed with `ruby-build` or `rbenv install`
#### Installed with `ruby-installer`
### Reinstalling Ruby from OS package managers
#### macOS: Built-in Ruby
#### macOS: Installed with Homebrew
#### Debian or Ubuntu: Installed with `apt-get`
#### Fedora: Installed with `dnf`
#### RHEL or CentOS: Installed with `yum`
#### Windows: Installed with Ruby Installer


## Additional help

### Another automated SSL check
### Still having trouble?
### Contributing to this guide




# Content that hasn't yet been slotted into a section

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


