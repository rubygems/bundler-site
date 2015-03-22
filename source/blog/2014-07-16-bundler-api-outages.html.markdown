---
title: Bundler API outages on July 15 & 16, 2014
date: 2014-07-16 23:29 UTC
author: André Arko
author_url: http://arko.net
category: postmortem
---

In the last couple of days, the Bundler API has seen some downtime: 53 minutes on July 15 and 3 hours  and 16 minutes on July 16. Here's what happened, and how we're working to keep it from happening again in the future.

The Bundler API provides information about specific gems, allowing `bundle install` to run more quickly. Without the API installing multiple gems is much slower, because information about every single gem has to be downloaded, instead of just information about the gems that are needed.

Starting with RubyGems version 2.2.0 (which is included with Ruby 2.1), the `gem install` also uses the API to download gem metadata more quickly. As users upgraded RubyGems (or were upgraded by upgrading their Ruby version), the load on the API slowly started to increase. We are usually able to successfully handle the increased load, but only up to a point. When enough large, slow requests are made simultaneously (some of you have really big Gemfiles!), unanswered API requests started to pile up while the slow requests ran. At that point, the problem snowballs pretty naturally, and the API starts responding very sluggishly, if it even manages to respond at all inside the hard 30 second timeout imposed by Heroku.

This snowball effect happens on occasion, and the solution is often as simple as dropping all the requests in the queue so that incoming requests can be served immediately. Yesterday, that wasn't enough. There were too many requests to handle even after dropping the backed up queue of waiting requests. Adding application servers is extremely straightforward, but there was a problem: the database server had reached its connection limit. If we added any more application servers, we would need additional database connections, and our current server was at the limits of its hardware.

To increase the number of allowed database connections, we had to upgrade to a bigger database. Fortunately, Heroku's Postgres tools make it simple to create a bigger database that follows the existing database, and then turn off replication and switch to using that bigger database as the new main database. Yesterday, I took down the API, created a new follower database that was able to support more connections, and then failed over to use it as the primary database. This resulted in roughly 53 minutes of downtime on July 15.

Unfortunately, replication to the new, bigger database was only partially complete when I manually failed over to that database. The automated process that synchronizes the main RubyGems.org database to the API database wasn't able to fill in all of the missing data due to the way replication had copied only part of the information about some gems.

Today, while investigating reports of failures during `bundle install`, we discovered the missing database data, and took down the API entirely to force everyone to use the accurate (but slower) full gem index. To repair the missing data, we restored a database backup from yesterday, and then synchronized the API database with the main RubyGems.org database to catch up on new gems. This caused roughly 3 hours and 16 minutes of downtime on July 16.

Since the API was already down, we took the opportunity to improve the API database infrastructure. With the bigger database, we were able to remove our replica setup and instead just use a single database. We were also able to upgrade from Postgres 9.2.4 to 9.3.4, with performance enhancements and automatic failover. In the future, primary database failures should now be handled automatically.

At this point, we have successfully upgraded to the latest version of Postgres, dramatically increased the hardware the database runs on, and increased the number of application servers from 15 to 20. We believe this fully armed and operational database will be faster and more reliable. Sorry for the downtime. Happy Bundling!
