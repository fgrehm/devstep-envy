# devstep-envy

[Devstep](http://fgrehm.viewdocs.io/devstep) and [Envy](https://github.com/progrium/envy)
holding hands.

```
Demo coming soon...
```

## Motivation

Envy is still on its early days but [@progrium's demo](https://vimeo.com/131329120)
[blew my mind](https://twitter.com/fgrehm/status/614046695106678784) in a way
that I could not hold myself from jumping into its code at its very early days
to [hack in support for using it with Devstep](https://github.com/progrium/envy/issues/19#issuecomment-115428854)
and provide some basic infrastructure to take "random acts of hacking" up to
another level.

The biggest motivation around this project is similar to what drives Devstep:

> I want to `git clone` and run a single command to hack on any software project.

Thanks to Envy, we can skip the "`git clone` and run a single command" part, let
Envy take care of that and use a browser to hack on many different GitHub open
source projects without the need to even think about `Dockerfile`s.

This project builds on top of Envy and includes some additional functionality
that is not yet provided by the project itself. Part of that is made of a
[Pull Request](https://github.com/progrium/envy/pull/25) I've submitted and the
other changes are around integration with Devstep that might be extracted and
contributed to Envy (like the support for building environments based on GitHub
projects itself).

## Requirements

A Linux machine with [Docker](https://www.docker.com/) installed.

## Installation

_:warning: This is **very** experimental, expect things to break :warning:_

```sh
git clone https://github.com/fgrehm/devstep-envy && cd devstep-envy
SSH_PORT=1234 make install
```

## Usage

Development environments can be accessed using SSH or from a browser. In addition
to Envy's (current) core functionality, this project provides support for building
environments based on GitHub projects and it leverages a Devstep's image for
automatic detection of projects dependencies (much like Heroku's "`git push`
+ buildpacks experience").

_Building Envy environments based on GitHub projects [is planned](https://github.com/progrium/envy/issues/19)
and the way things are implemented right now are based around that_

To hack on a GitHub project you can either visit `http://devstep-envy.host/gh/A_USER/PROJECT`
or:

```sh
ssh MY_GH_USER+github.com/SOME_USER/PROJECT@devstep-envy.host
```

## Development

```sh
git clone https://github.com/fgrehm/devstep-envy && cd devstep-envy
make hack
```

And from another terminal:

```sh
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2222 MY_GH_USER@localhost
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2222 MY_GH_USER+github.com/SOME_USER/PROJECT@localhost
```
