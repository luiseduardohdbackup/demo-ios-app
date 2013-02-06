# Demo iOS Application

Nothing special. Just an attempt at writing a native iOS app that communicates
with an API and parses JSON to present a restaurant menu and a map location.

It compiles and runs. Start up the server to see data.

## Where's the server?

    $ cd ruby-api && ruby app.rb

It runs on `localhost:5000`, which is what the app is configured to query. You
can change that in `app.rb` and in the project's `Info.plist`, under `AppApiUrl`.

## Problems

The contact page randomly blows up. Also, after the change from Google Maps to
Apple's own maps, the contact page info bubble no longer appears (and neither
does the contact information)
