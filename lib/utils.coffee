exports.merge = (dest, src) ->
  if dest and src
    for key of src
      dest[key] = src[key]
  dest
