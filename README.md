# (experimental) nvim-buoy

A Neovim plugin to create floating window UI components.

**NOTE:** This plugin is experimental at the moment. More information will be
added here in the coming months.

## Installation

You can install this plugin with your favourite package manager. As an example,
for [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'sam4llis/nvim-buoy'
```

## Usage

### Create a New Floating Window

You can create a reusable floating window assigned to a variable using the
following command:

```
:lua window = require('nvim-buoy').new({ percentage = 0.5 })
```

The `percentage` option denotes the applied width of the floating window
(relative to the size of the editor view).

### Open and Closing a Floating Window

You can open a previously created floating window instance using the following
command:

<!-- TODO: add a gif here. -->
```
:lua window:open()
```

Closing the floating window is possible using the usual `:q` or:

<!-- TODO: add a gif here. -->
```
:lua window:close()
```

### Toggle a Floating Window

Alternatively, the `open()` and `close()` commands can be toggled using the
following command:

```
:lua window:toggle()
```
