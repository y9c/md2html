-- Pandoc filter to process code blocks with class "mermaid" containing
-- mermaid notation into images.
--
-- * Assumes that abcm2ps and ImageMagick's convert are in the path.
-- * For textual output formats, use --extract-media=abc-images
-- * For HTML formats, you may alternatively use --self-contained

local mmdc = string.gsub(debug.getinfo(1).source, "^@(.+/)[^/]+/[^/]+$", "%1") .. "node_modules/.bin/mmdc"
-- -i example/input.mmd -o example/output.svg
print(mmdc)

local filetypes = {
  html = {"png", "image/png"},
  latex = {"pdf", "application/pdf"}
}
local filetype = filetypes[FORMAT][1] or "svg"
local mimetype = filetypes[FORMAT][2] or "image/svg+xml"

local function mermaid2svg(code)
  local tmpfile = os.tmpname()
  local tmpdir = string.match(tmpfile, "^(.*[\\/])") or "."
  local mermaid_file = tmpfile .. ".mmd"
  local svg_file = tmpfile .. ".svg"
  local f = io.open(mermaid_file, "w")
  f:write(code)
  f:close()
  os.execute(mmdc .. " -i " .. mermaid_file .. " -o " .. svg_file)
  return svg_file
end

function CodeBlock(block)
  if block.classes[1] == "mermaid" then
    local fname = mermaid2svg(block.text)
    pandoc.mediabag.insert(fname, mimetype, img)
    return pandoc.Para {pandoc.Image({pandoc.Str("abc tune")}, fname)}
  end
end
