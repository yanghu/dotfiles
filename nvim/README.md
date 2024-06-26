<!--toc:start-->

**TOC**

- [Keymaps](#keymaps)
- [Locations management and jump](#locations-management-and-jump)
<!--toc:end-->

## Plugins

## Keymaps

### Cheatsheet

- **Treesitter Text objects**: With treesitter text objects, you can use motion
  on code objects like "argument", "assignment (left)", etc. Examples
  - `cr=`: [C]hange [R]hs of [=]
  - `caa`: [C]hange a [A]rgument
  - `cii`: [C]hange [i]n [I]f: This is very useful, depending on cursor position.
    It selects the "if" condition, or selects the conditional body when cursor
    is inside the body.
  - `cil`: similar, but works on [L]oops.

### Text objects

### Diagnostics

### Misc

##### Markdown preview

`<leader>cp`: toggle preview

## Diagnostics and locations

The lists can be populated by:

- LSP: populates `diagnostics`, `symbols`, etc.
- Telescope/FZF: can populate `quickfix` and `location_list` with search results.

  The results can be viewed/used in a uniformed fashion with the `trouble` plugin.

### Populating Quickfix / location lists

In `Telescope`, use `tab` and `s-tab` to select entries, then use `C-q` to send
them to quickfix list. If nothing is selected, all entries are sent.
This is achieved by using `smart_send_qflist` action in `Telescope`.

Grep results can be sent to qflist for further processing, like `:cdo`, `:cfdo`, etc.
It's also easier to browse and jump through the locations later.

### Trouble keymaps

Openinig lists

| keymap     | List opened             | comment |
| ---------- | ----------------------- | ------- |
| <Leader>xx | Diagnostics (workspace) | Item3.1 |
| <Leader>xX | Diagnostics (document)  | Item3.2 |
| <Leader>xs | Symbols                 | Item3.3 |
| <Leader>xq | Quickfix                | Item3.4 |

In Trouble's window (press "?" to see help)
