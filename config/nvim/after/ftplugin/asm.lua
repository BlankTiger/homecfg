_G.asm_indent = function(ln)
  local shift = vim.fn.shiftwidth()
  local line = vim.fn.getline(ln):gsub(";.*", "")

  if line:match("^%s*%w[%w_]*:%s*$") then
    return 0
  end

  local prev = vim.fn.prevnonblank(ln - 1)
  if prev == 0 then
    return 0
  end

  local prev_line = vim.fn.getline(prev):gsub(";.*", "")
  if prev_line:match("^%s*%w[%w_]*:%s*$") then
    return shift
  end

  return vim.fn.indent(prev)
end

vim.schedule(function()
  vim.bo.indentexpr = "v:lua.asm_indent(v:lnum)"
end)
