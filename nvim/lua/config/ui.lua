local M = {}
-- icons
M.icons = {
  diagnostics = {
    ' ',
    ' ',
    ' ',
    ' ',
    '󰄭 '
  },
  git = {
    -- added = '󰐖 ', modified = '󰅗  ', removed = '󰍵  ', renamed = '󰛂 '
    -- added = '󰜄  ', modified = '󰅘  ', removed = '󰛲  ', renamed = '󰜶 '
    added = '󰐙 ',
    modified = '󰅚  ',
    removed = '󰍷  ',
    renamed = '󰳠 ',
    untracked = ' ',
    ignored   = ' ',
    unstaged  = ' ',
    staged    = ' ',
    conflict  = ' '
  },
  kinds = {
    Array = ' ', -- ' ', -- '󰕤 ',
    Boolean = ' ', -- ' ', --'󰘨 ',
    Class = ' ', -- '󰌗 ', -- ' ',
    Color = ' ', -- '󰏘 ', -- ' ',
    Constant = ' ', -- ' ',
    Constructor = ' ', -- ' ', -- ' ', -- ' ',
    Enum = ' ', -- ' ', -- '󰕘 ',
    EnumMember = ' ', -- ' ', -- ' ',
    Event = ' ', -- ' ', -- ' ',
    Field = ' ', -- '󰆧 ', -- ' ',
    File = ' ', -- ' ', -- ' ',
    Folder = ' ', -- ' ',
    Function = '󰊕 ', -- ' ',
    Interface = ' ', -- ' ', -- ' ',
    Keyword = ' ', -- ' ', -- '󰌋 ', -- ' ',
    Method = ' ', -- '󰊕 ',
    Module = ' ', -- '󰅩 ',
    Namespace = ' ', -- '󰅩 ',
    Number = ' ', -- ' ', -- '󰐣 ',
    Object = ' ', -- '󰗀 ',
    Operator = ' ', -- '󰒕 ',
    Package = ' ', -- ' ', -- '󰏖  ',
    Property = ' ', -- ' ', -- ' ',
    Reference = ' ', -- '  ', -- '󰈇 ' -- ' ',
    Snippet = ' ', -- ' ', '󰈙 ', -- ' ', !!!
    String = ' ', -- ' ', -- ' ',
    Struct = ' ', -- ' ',  --'󱏒 ', -- ' ',
    Text = ' ', -- '  ', -- ' ',
    TypeParameter = ' ', -- ' ', -- ' ', -- ' ',
    Unit = '󰺾 ', -- '󰑭 ', -- '󰜫 '  --' ',
    Value = '󰎠 ', -- ' ',
    Variable = ' ', -- '󰆧 ', -- ' ',
  },
  lazy = {
    cmd = ' ',
    config = ' ',
    event = ' ',
    ft = ' ',
    import = ' ',
    init = ' ',
    keys = ' ',
    plugin = ' ',
    runtime = ' ',
    source = ' ',
    start = ' ',
    task = ' ',
  }
}

-- borders --
-- M.borders = { '╤', '═', '╤', '│', '╧', '═', '╧', '│' }
-- M.borders = { '╓', '─', '╖', '║', '╜', '─', '╙', '║' }
-- M.borders = { '┯', '━', '┯', '│', '┷', '━', '┷', '│' }
-- M.borders = { '·', '─', '·', '│', '·', '─', '·', '│' }
-- M.borders = { '╏', '🮂', '╏', '╏', '╏', '▂', '╏', '╏' }
-- M.borders = { '┎', '─', '┒', '┃', '┚', '─', '┖', '┃' }
-- M.borders = { '┬', '─', '┬', '│', '┴', '─', '┴', '│' }
M.borders = 'rounded'

return M
