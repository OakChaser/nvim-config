-- 语言无关的「可见性」判定引擎，供 aerial 的 post_parse_symbol 使用。
--
-- 每条规则形如 `function(bufnr, item, ctx) -> "public"|"private"|"protected"|nil`
-- 返回 nil 表示不做判断（沿用 aerial 自己的行为，例如 ruby 的查询文件已经带了 scope）。
-- aerial 会把非 public 的 scope 渲染成 AerialPrivate / AerialProtected 高亮组
-- （默认链接到 Comment），也可以自己用 aerial 的 get_highlight 覆盖。
--
-- 想支持新语言：往 M.rules 里加一条，或在配置文件里覆盖 M.rules[ft]。
-- 注意 filetype 名：.tsx 是 typescriptreact，.jsx 是 javascriptreact。

local M = {}

--- 文本里是否出现完整的关键字
---@param text string
---@param word string
---@return boolean
function M.has_word(text, word)
  return text:find("%f[%w]" .. word .. "%f[%W]") ~= nil
end

--- 符号名之前的文本：符号起始行的行首 -> 符号名。
--- 行首（而不是符号节点起点）是必要的：TypeScript 的 `export`、Java 的
--- `public`、`static` 等修饰符在 treesitter 节点之外；跨行属性（Rust 的
--- `#[inline]`）也在节点之外，由多行拼接覆盖。
---@param bufnr integer
---@param item aerial.Symbol
---@return string
function M.header(bufnr, item)
  local name_range = item.selection_range
  local end_lnum = (name_range and name_range.lnum) or item.lnum
  if end_lnum < item.lnum then
    end_lnum = item.lnum
  end
  local lines = vim.api.nvim_buf_get_lines(bufnr, item.lnum - 1, end_lnum, false)
  if #lines == 0 then
    return ""
  end
  if name_range and name_range.lnum == end_lnum then
    lines[#lines] = lines[#lines]:sub(1, name_range.col)
  end
  return table.concat(lines, "\n")
end

-- 按修饰符关键字判定，spec.default 为没有关键字时的默认结果。
-- 未显式给出关键字列表时，默认认 private / protected / public 三个修饰符。
local function by_modifiers(header, spec)
  for _, word in ipairs(spec.private or { "private" }) do
    if M.has_word(header, word) then
      return "private"
    end
  end
  for _, word in ipairs(spec.protected or { "protected" }) do
    if M.has_word(header, word) then
      return "protected"
    end
  end
  for _, word in ipairs(spec.public or { "public" }) do
    if M.has_word(header, word) then
      return "public"
    end
  end
  return spec.default
end

--------------------------------------------------------------------------
-- TypeScript / JavaScript
--------------------------------------------------------------------------
-- 类 / 接口 / 命名空间成员：缺省就是 public
local function ts_member(bufnr, item)
  if item.name:find("^#") then
    return "private" -- #privateField
  end
  return by_modifiers(M.header(bufnr, item), { default = "public" })
end

-- 模块级声明：只有 export 出去才对模块外可见
local function ts_toplevel(bufnr, item)
  local header = M.header(bufnr, item)
  for _, word in ipairs({ "private", "protected" }) do
    if M.has_word(header, word) then
      return ts_member(bufnr, item)
    end
  end
  return M.has_word(header, "export") and "public" or "private"
end

local MEMBER_PARENTS = { Class = true, Interface = true, Module = true, Namespace = true }

local function ts_vis(bufnr, item)
  if item.parent and MEMBER_PARENTS[item.parent.kind] then
    return ts_member(bufnr, item)
  end
  return ts_toplevel(bufnr, item)
end

--------------------------------------------------------------------------
-- C++：类成员的可见性由所在 public:/private:/protected: 段决定，
-- 文本上看不出来，得回看 treesitter 祖先与前面的兄弟节点。
--------------------------------------------------------------------------
local function cpp_access(bufnr, ctx)
  local match = ctx and ctx.match
  local captured = match and (match.symbol or match.type)
  local node = captured and captured.node
  if not node then
    return nil
  end
  local parent = node:parent()
  while parent do
    local ptype = parent:type()
    if ptype == "field_declaration_list" then
      -- 找到直接挂在该列表下的那个成员节点
      local member = node
      while member and member:parent() ~= parent do
        member = member:parent()
      end
      if not member then
        return nil
      end
      -- 取它之前最近的一个 access_specifier
      local access
      for i = 0, parent:named_child_count() - 1 do
        local child = parent:named_child(i)
        if child:start() >= member:start() then
          break
        end
        if child:type() == "access_specifier" then
          access = child
        end
      end
      if access then
        local text = vim.treesitter.get_node_text(access, bufnr)
        if text:find("private") then
          return "private"
        elseif text:find("protected") then
          return "protected"
        elseif text:find("public") then
          return "public"
        end
      end
      -- 没有任何 access specifier：class 默认私有，struct/union 默认公有
      local owner = parent:parent()
      local otype = owner and owner:type()
      if otype == "struct_specifier" or otype == "union_specifier" then
        return "public"
      end
      return "private"
    end
    parent = parent:parent()
  end
  return nil
end

--------------------------------------------------------------------------
-- 规则表
--------------------------------------------------------------------------
M.rules = {
  -- 关键字修饰符：有 pub 即对外
  rust = function(bufnr, item)
    return M.has_word(M.header(bufnr, item), "pub") and "public" or "private"
  end,

  typescript = ts_vis,
  typescriptreact = ts_vis,
  tsx = ts_vis,
  javascript = ts_vis,
  javascriptreact = ts_vis,
  jsx = ts_vis,

  -- 命名约定：_ / __ 私有，__xx__ 是魔法方法
  python = function(_, item)
    local name = item.name
    if name:find("^__") and not name:find("__$") then
      return "private"
    elseif name:find("^_") then
      return "private"
    end
    return "public"
  end,
  -- Dart 用 _ 表示库内私有
  dart = function(_, item)
    return item.name:find("^_") and "private" or "public"
  end,
  -- 命名约定：大写开头为导出
  go = function(_, item)
    return item.name:find("^%u") and "public" or "private"
  end,
  -- local function / local M = ...
  lua = function(bufnr, item)
    return M.has_word(M.header(bufnr, item), "local") and "private" or "public"
  end,

  -- 修饰符关键字：缺省即包内/模块内可见，算内部
  java = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), { default = "private" })
  end,
  csharp = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), { default = "private" })
  end,
  kotlin = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), {
      private = { "private", "internal" },
      protected = { "protected" },
      default = "public",
    })
  end,
  swift = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), {
      private = { "private", "fileprivate" },
      public = { "public", "open" },
      default = "private", -- internal
    })
  end,
  php = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), { default = "public" })
  end,
  scala = function(bufnr, item)
    return by_modifiers(M.header(bufnr, item), {
      private = { "private" },
      protected = { "protected" },
      default = "public",
    })
  end,

  -- C：static 是内部链接（仅本文件可见）
  c = function(bufnr, item)
    return M.has_word(M.header(bufnr, item), "static") and "private" or "public"
  end,
  cpp = function(bufnr, item, ctx)
    local access = cpp_access(bufnr, ctx)
    if access then
      return access
    end
    return M.has_word(M.header(bufnr, item), "static") and "private" or "public"
  end,
}

---@param bufnr integer
---@param item aerial.Symbol
---@param ctx? table post_parse_symbol 的 ctx（treesitter 后端才有 match 等）
---@return "public"|"private"|"protected"|nil
function M.get(bufnr, item, ctx)
  local rule = M.rules[vim.bo[bufnr].filetype]
  if not rule then
    return nil
  end
  return rule(bufnr, item, ctx)
end

return M
