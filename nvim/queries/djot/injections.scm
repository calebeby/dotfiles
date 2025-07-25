; I added this one

(frontmatter
  (#set! injection.language "yaml")
  (frontmatter_content) @injection.content)


; below here copied from https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/djot/injections.scm
; (I do have to have copies of all of them, the injection queries are not merged with the default)

((comment) @injection.content
  (#set! injection.language "comment"))

(math
  (content) @injection.content
  (#set! injection.language "latex"))

(code_block
  (language) @injection.language
  (code) @injection.content)

(raw_block
  (raw_block_info
    (language) @injection.language)
  (content) @injection.content)

(raw_inline
  (content) @injection.content
  (raw_inline_attribute
    (language) @injection.language))

(frontmatter
  (language) @injection.language
  (frontmatter_content) @injection.content)
