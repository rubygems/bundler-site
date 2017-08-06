# How Bundler uses SSL certificates

## Introduction

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

[1]: ssl_troubleshooting.html