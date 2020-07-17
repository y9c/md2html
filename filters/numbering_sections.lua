--
-- numbering_sections.lua
-- https://gist.github.com/rauschma/458303094cd87cab077c00c061cce8da
--

local headersToIgnore = {
  ["List of Figures"] = true,
  ["List of Listings"] = true,
  ["List of Tables"] = true,
}

local counters = {};

function Header(el)
  local headerPlainText = pandoc.utils.stringify(el)
  if headersToIgnore[headerPlainText] then
    return nil
  end
  local level = el.level
  local firstCounterLevel
  if level == 1 then
    -- Parts don’t affect any other level
    atLeastLevel(level)
    firstCounterLevel = 1
  else
    atLeastLevel(level)
    atMostLevel(level)
    firstCounterLevel = 2
  end
  counters[level] = counters[level] + 1
  local content = concat(
    {pandoc.Str(countersToString(firstCounterLevel, level) .. " ")},
    el.content)
  return pandoc.Header(el.level, content, el.attr)
end

function atLeastLevel(level)
  while #counters < level do
    table.insert(counters, 0)
  end
end

function atMostLevel(level)
  while #counters > level do
    table.remove(counters)
  end
end

function countersToString(firstCounterLevel, lastCounterLevel)
  local result = ""
  for k,v in pairs(counters) do
    if k > lastCounterLevel then break end
    if k >= firstCounterLevel then
      if k == 1 then
        result = result .. pandoc.utils.to_roman_numeral(v) .. "."
      else
        result = result .. v .. "."
      end
    end
  end
  return result
end

function insertInto(source, target)
  for _,v in pairs(source) do
    table.insert(target, v)
  end
  return target
end

function concat(t1, t2)
  local result = {};
  insertInto(t1, result)
  insertInto(t2, result)
  return result
end
