# Config rewrite
This document describes everything I want from a future rewrite. Decided to write it all down here
over several days in order to get all of my wants in order before beginning the rewrite.

## Why?
Right now I have a bloated config which is derived from a "minimal" distro.
It has turned into quite the mess, full of unused plugins and commented out code, and I am looking
for a fresh start, where I know the ins and outs of the config, and I have full control over all the
external dependencies and where each feature comes from.

This should hopefully make the config a wee bit more maintainable, and not make me pull my hair out
when there's something not working the way I expect.

## Theme
Nord.

## Update to the newest neovim version
This is probably the best time to update the version, and I haven't done it in a while.

## Plugins
I am a bit split on using lazy.nvim or the new built in plugin manager. I have had no issues with
lazy so far, but it could be nice to reduce external dependencies by using the built in one.

### Plugins I am bringing over from the old config
- [ ] ***stevearc/oil.nvim:*** The best file browser I have tried
- [ ] ***ThePrimeagen/harpoon.nvim:*** Fast jump between files
- [ ] ***nvim-telescope/telescope.nvim:*** I don't need to explain myself
- [ ] ***prettier/vim-prettier:*** Mostly for work
- [ ] ***editorconfig/editorconfig-vim:*** Same reason as prettier
- [ ] ***williamboman/mason.nvim:*** Wouldn't you?
- [ ] ***jake-stewart/multicursor.nvim:*** It's just too good
- [ ] ***hrsh7th/nvim-cmp:*** Very nice to have sometimes
- [ ] ***nvim-treesitter/nvim-treesitter:*** Eh, why not
- [ ] ***lewis6991/gitsigns.nvim:*** Don't use any of the functionality except the column signs
- [ ] ***xiyaowong/transparent.nvim:*** Get transparent backgrounds
- [ ] ***folke/lazydev.nvim:*** Better lua support when writing my config
- [ ] ***mfussenegger/nvim-dap*** + ***rcarriga/nvim-dap-ui:***: Works fine. I just need to make
    some changes to my [adap setup](#ADAP) to make it work better

### Plugins I don't know if I should keep or not
- ***github/copilot.vim:*** Does come in handy like 5% of the time, but man is it annoying
- ***sylvanfranklin/omni-preview.nvim*** + ***toppair/peek.nvim:*** Don't like the dependencies
    and it's slow as balls, but it's really nice to have sometimes.
- ***L3MON4D3/LuaSnip:*** Looks kinda cool, if only I knew how to use it

### Plugins I should take a look at
- ***zerochae/endpoint.nvim:*** Looks like swagger integrated into neovim with definition location
- ***chentoast/marks.nvim:*** I have not used marks too much, but this might make it easier

## ADAP
This is my own DAP setup for automatically compiling the executable before starting the debugger.
It works well enough except for a few things:
- [ ] Rename .adaprc to .adap.json since it uses json and that means I get syntax highlighting, and
    rc suffix doesn't really make sense, I just thought it sounded cool at the time.
- [ ] Needs a proper wizard so I don't have to manually write the .adap.json file for each project
- [ ] Make the config file more flexible
    - compile directory (in what directory should the compilation happen)
    - compile command
    - run directory (the current working directory essentially)
    - run command (This way I can add flags to the run commands)
- [ ] \(optional) Come up with a better name

## Mappings
Most, if not all of the old mappings should be moved over, but if I can't remember using it the last
few months it should probably go. In addition all plugin specific mapping should be moved to the
config procedure for the plugin

New mappings i would like:
- [ ] A way to toggle between tabs and spaces (either through a mapping or a short command)
- [ ] A way to quickly set tab size (shift width and tab width)
- [ ] Shortcut to searching for symbols in the odin standard library using telescope. This shouldn't
    be too hard, I just need to decide on what path to search in. Right now I have installed odin
    through homebrew, but I think I want to compile it myself and keep the source files in the GH/
    directory instead.
- [ ] A shortcut for running 'Gitsigns toggle_current_line_blame', leader+g+b maybe
- [ ] Mappings for running ':Prettier'

## Future maintenance
I would like to have an easy way to take note of changes to the config that I want, a sort of
wishlist. And maybe have a day once a month or so where I go through the notes and do the changes.

It could be nice to have this wishlist as a built in neovim thing, but I could also have a markdown
document just like this one that I can add entries to as I go along.
