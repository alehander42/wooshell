# wooshell

## Setup easily terminal environments for gnome

I often need a certain environment for a project: e.g. docker-compose in one tab, rails console in the next one, ssh in another 2, a waiting tab, vim in another one.

I don't like tmux because I don't need the split screen functionallity and without it it's an overkill.

With nome I can easily generate this kind of environment based on an yaml file.

It's a thin wrapper around `gnome-terminal`.

e.g.

```yaml
profile: a
shell: fish
tabs:
  - >
  	docker-compose up
  - >
    sleep 10
    docker exec -it app_web_1 bundle exec rails c
  - >
    ssh -t a@b
  - >
    ssh -t b@c
  - ''
  - vim README.md
workdir: ~/a
```

## Config

### tabs 

A list of tabs, each tab has a string list of commands. >, because I still don't deal with any newlines in the commands, just join them with ;

### workdir

Workdir is optional, if you set it with a string dir, it will add cd dir to each of the tabs (you can obviously use cd after that for custom cases)

### shell

Shell can be set to fish if you use it: then the tab will be executed as fish -c 'commands; fish'. Otherwise it will use your default shell.

### profile

Personal profile

## Install

It's written in Nim, so it's compiled to a single binary. Currently there is only a Linux 64bit build, as it's not useful for Windows/OS X.


## LICENSE

License is MIT, Alexander Ivanov 2017.


