-- function Strong(elem)
--   return pandoc.SmallCaps(elem.c)
-- end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


-- use by adding {wrap=3} to the image
if FORMAT:match 'latex' then
  function Image(elem)
    -- wrap figures.
    size=2
    print(elem.src)
    -- print(dump(elem))
    -- print(dump(elem.caption))
    -- print(pandoc.utils.stringify(elem.caption))
    if elem.attributes.wrap then
      local latex_begin=[[\setlength{\intextsep}{2pt}\setlength{\columnsep}{8pt}\begin{wrapfigure}{R}{]] .. elem.attributes.wrap .. 'in}'
      local latex_fig = [[\centering\includegraphics{]] .. elem.src .. [[}\caption{]]
      local latex_end = [[}\vspace{-5pt}\end{wrapfigure}]]
      print(dump(pandoc.RawInline('latex', latex_begin)))
      return_value =  {
        pandoc.RawInline('latex', latex_begin),
        pandoc.RawInline('latex', latex_fig),
        pandoc.RawInline('latex', latex_end)
      }
      rval = elem.caption
      table.insert(rval, 1, pandoc.RawInline('latex', latex_fig))
      table.insert(rval, 1, pandoc.RawInline('latex', latex_begin))
      table.insert(rval, pandoc.RawInline('latex', latex_end))
      print(dump(rval))
      print(pandoc.utils.stringify(rval))
      return rval
    else
      return elem
    end
  end
end

