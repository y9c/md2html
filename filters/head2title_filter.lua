local title

function promote_header(header)
  if header.level == 1 then
    if not title then
      title = header.content
      return {}
    else
      print(header)
      local msg = '[WARNING] title already set; discarding header "%s"\n'
      io.stderr:write(msg:format(pandoc.utils.stringify(header)))
    end
  end
end

return
  {
    -- read title from meta
    {
      Meta =
        function(meta)
          title = meta.title
        end,
    },
    -- read title from header
    {Header = promote_header},
    -- set title into meta
    {
      Meta =
        function(meta)
          meta.title = title;
          return meta
        end,
    },
  }
