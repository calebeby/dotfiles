// @ts-check

const fs = require('fs')
const { promisify } = require('util')
const path = require('path')
const readFile = promisify(fs.readFile)
const writeFile = promisify(fs.writeFile)
const mkdir = promisify(fs.mkdir)
const glob = require('tiny-glob')
const { mix } = require('polished')

const outdir = path.join(__dirname, 'colors')

const main = async () => {
  const colorschemePaths = (
    await glob('**.y{a,}ml', {
      cwd: path.join(__dirname, 'colorschemes'),
    })
  ).map((p) => path.resolve(__dirname, 'colorschemes', p))

  await mkdir(outdir, { recursive: true })

  await Promise.all(colorschemePaths.map(processColorScheme))
}

/**
 * @typedef {Object} ColorScheme
 * @property {string} name
 * @property {{
 *   base00: string
 *   base01: string
 *   base02: string
 *   base03: string
 *   base04: string
 *   base05: string
 *   base06: string
 *   base07: string
 *   base08: string
 *   base09: string
 *   base0A: string
 *   base0B: string
 *   base0C: string
 *   base0D: string
 *   base0E: string
 *   base0F: string
 * }} colors
 */

/**
 * @param {string} colorschemePath Absolute path to colorscheme yaml file
 * @returns {Promise<ColorScheme>}
 */
const readColorScheme = async (colorschemePath) => {
  const text = await readFile(colorschemePath, 'utf-8')
  /** @type {string} */
  let name
  const colors = /** @type {ColorScheme["colors"]} */ ({})
  const lines = text.split('\n')
  for (const line of lines) {
    const trimmed = line
      .replace(/^#.*$/, '')
      .replace(/\s+#.*$/, '')
      .trim()
    if (trimmed === '') continue
    const [, k, v] = trimmed.match(/([\w\d]+)\s*:\s*(.*)$/)
    const cleanedVal = v.replace(/^["'#]*/, '').replace(/["']$/, '')
    if (k.startsWith('base')) {
      colors[k] = `#${cleanedVal}`
    } else if (k === 'scheme') name = cleanedVal
  }
  return { name, colors }
}

/**
 * @param {string} colorschemePath Absolute path to colorscheme yaml file
 */
const processColorScheme = async (colorschemePath) => {
  const colorscheme = await readColorScheme(colorschemePath)
  const name = colorscheme.name
    .replace(/\s+/g, '_')
    .replace(/[^\w\d]/g, '')
    .toLowerCase()
  const outputText = await generateVimText(colorscheme, name)
  await writeFile(path.join(outdir, `${name}.vim`), outputText)
}

/**
 * @param {ColorScheme} colorscheme
 * @param {string} vimName the name that vim will know the color scheme as
 */
const generateVimText = async (colorscheme, vimName) => {
  let file =
    `
    set bg=dark
    hi clear
    syntax reset
    let colors_name = "${vimName}"
  `
      .trim()
      .split('\n')
      .map((line) => line.trim())
      .join('\n') + '\n\n'

  const {
    base00,
    base01,
    base02,
    base03,
    base04,
    base05,
    base06,
    base07,
    base08,
    base09,
    base0A,
    base0B,
    base0C,
    base0D,
    base0E,
    base0F,
  } = colorscheme.colors

  /**
   * @param {string} group
   * @param {string} guifg
   * @param {string} guibg
   * @param {string} [gui]
   * @param {string} [guisp]
   */
  const highlight = (group, guifg, guibg, gui, guisp) => {
    let line = `hi ${group}`
    if (guifg) line += ` guifg=${guifg}`
    if (guibg) line += ` guibg=${guibg}`
    if (gui) line += ` gui=${gui}`
    if (guisp) line += ` guisp=${guisp}`
    file += line + '\n'
  }

  highlight('Normal', base05, base00, '', '')
  highlight('Visual', '', base02, '', '')

  highlight('VertSplit', base02, base02, 'none', '')
  highlight('StatusLine', base04, base02, 'none', '')
  highlight('StatusLineNC', base03, base01, 'none', '')
  highlight('LineNr', base03, base00, '', '')
  highlight('CursorLineNr', base04, base00, '', '')
  highlight('Cursor', base00, base05, '', '')
  highlight('Cursor', base00, base05, '', '')
  highlight('CursorLine', '', base01, 'none', '')
  highlight('NonText', base03, '', '', '')
  highlight('QuickFixLine', '', base01, 'none', '')
  highlight('Error', base00, base08, '', '')
  highlight('Underlined', base08, '', '', '')
  highlight('Title', base0D, '', 'none', '')
  highlight('TabLine', base03, base00, 'none', '')
  highlight('TabLineFill', base03, base00, 'none', '')
  highlight('TabLineSel', base05, base01, 'bold', '')

  highlight('IncSearch', base01, base09, 'none', '')
  highlight('Search', base01, base0A, '', '')

  highlight('Comment', base03, '', 'italic', '')
  highlight('String', base0B, '', '', '')
  highlight('Statement', base0E, '', 'none', '')
  highlight('Type', base0A, '', 'none', '')
  highlight('Operator', base0E, '', 'none', '') // this one deviates, i like operators to have colors
  highlight('Identifier', base08, '', 'none', '')
  highlight('Special', base0C, '', 'none', '')
  highlight('Constant', base09, '', 'none', '')
  highlight('PreProc', base0A, '', '', '')
  highlight('Function', base0D, '', '', '')

  highlight('xmlTag', base05, '', '', '')
  highlight('xmlEndTag', base05, '', '', '')
  highlight('xmlTagName', base08, '', '', '')
  highlight('xmlTagN', base08, '', '', '')
  highlight('xmlAttrib', base0D, '', '', '')

  highlight('SpellBad', '', '', 'undercurl', base08)
  highlight('SpellLocal', '', '', 'undercurl', base0C)
  highlight('SpellCap', '', '', 'undercurl', base0D)
  highlight('SpellRare', '', '', 'undercurl', base0E)

  highlight('CocHighlightText', '', base01, '', '')
  highlight('CocErrorSign', base08, '', '', '')
  highlight('CocWarningSign', base09, '', '', '')
  highlight('CocHintSign', base0B, '', '', '')
  highlight('CocInfoSign', base0D, '', '', '')

  const diffAdd = mix(0.25, base0B, base00)
  const diffDelete = mix(0.25, base08, base00)
  const diffDeletedLine = mix(0.85, base00, base08)
  const diffChange = mix(0.25, base0D, base00)

  // diff buffer
  highlight('DiffAdd', '', diffAdd, 'none', '')
  highlight('DiffChange', '', base00, '', '')
  highlight('DiffDelete', diffDeletedLine, diffDeletedLine, 'none', '')
  highlight('DiffText', '', diffAdd, 'none', '')

  // fugitive uses this, signify diff hunk as well
  highlight('DiffAdded', base0B, base00, '', '')
  highlight('DiffFile', base08, base00, '', '')
  highlight('DiffNewFile', base0B, base00, '', '')
  highlight('DiffLine', base0D, base00, '', '')
  highlight('DiffRemoved', base08, base00, '', '')

  highlight('SignifySignAdd', base04, diffAdd, '', '')
  highlight('SignifySignChange', base04, diffChange, '', '')
  highlight('SignifySignDelete', base04, diffDelete, '', '')

  highlight('PMenu', base05, base01, 'none', '')
  highlight('PMenuSel', base01, base05, '', '')

  highlight('Todo', base0A, base01, '', '')

  highlight('Folded', base03, base01, '', '')
  highlight('FoldColumn', base0C, base00, '', '')

  return file
}

main()
