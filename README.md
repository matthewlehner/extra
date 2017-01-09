# Extra

## Setup

* Clone this repo
* Install dependencies with homebrew by running `script/setup`

* This will install Erlang, Elixir, Node, and Yarn, grab the Elixir and Node
  dependencies

* Install and set up [direnv](https://direnv.net) (`brew install direnv`)
* Add `eval "$(direnv hook bash)"` to `~/.bashrc` or
  `eval "$(direnv hook zsh)"` `~/.zshrc` depending on what shell you use. If
  you don't know, it's probably `bash`, so use the first option.
* Restart your console.
* Symlink the config file from our shared Dropbox folder:
  `ln -nfs ~/Dropbox/Projects/Extra/Development\ Resources/.envrc`

* Tell `direnv` to allow the local config file: `direnv allow .`
* Start the server `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
