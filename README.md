# Demo iOS Application

Nothing special. Just an attempt at writing a native iOS app that communicates
with an API and parses JSON to present a restaurant menu and a map location.

It doesn't compile due to some required libraries being missing (or misunderstanding
the strange way XCode deals with adding files from external projects). One day
that may be fixed.

## Where's the API?

    $ git checkout php-api

The code references a remote URL (that no longer exists). It needs to be changed
to a local one. You can see the hard-coded responses it gets, though.
