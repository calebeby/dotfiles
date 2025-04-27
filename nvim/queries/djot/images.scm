(inline_image 
  [
    (inline_link_destination) @image.src
  ]
    (#gsub! @image.src "^[(]" "") ; remove brackets (couldn't figure out how to escape the paren)
    (#gsub! @image.src "[)]$" "") ; remove brackets
  ) @image
