-- tikz2iamge_filter.lua
-- Copyright (C) 2020 Ye Chang <yech1990@gmail.com>
--
-- Distributed under terms of the MIT license.
--
local function tikz2image(src, filetype, outfile)
  local tmp = os.tmpname()
  local tmpdir = string.match(tmp, "^(.*[\\/])") or "."
  local f = io.open(tmp .. ".tex", "w")
  f:write("\\documentclass{standalone}\n\\usepackage{xcolor}\n\\usepackage{tikz}\n\\begin{document}\n\\nopagecolor\n")
  f:write(src)
  f:write("\n\\end{document}\n")
  f:close()
  os.execute("pdflatex -output-directory " .. tmpdir .. " " .. tmp)
  if filetype == "pdf" then
    os.rename(tmp .. ".pdf", outfile)
  else
    os.execute("pdf2svg " .. tmp .. ".pdf " .. outfile)
  end
  os.remove(tmp .. ".tex")
  os.remove(tmp .. ".pdf")
  os.remove(tmp .. ".log")
  os.remove(tmp .. ".aux")
end

extension_for = {
  html = "svg",
  html4 = "svg",
  html5 = "svg",
  latex = "pdf",
  beamer = "pdf"
}

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function starts_with(start, str)
  return str:sub(1, #start) == start
end

function RawBlock(el)
  if starts_with("\\begin{tikzpicture}", el.text) then
    local filetype = extension_for[FORMAT] or "svg"
    local fname = pandoc.sha1(el.text) .. "." .. filetype
    if not file_exists(fname) then
      tikz2image(el.text, filetype, fname)
    end
    return pandoc.Para({pandoc.Image({}, fname)})
  else
    return el
  end
end
