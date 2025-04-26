import { readFile, writeFile, mkdir } from 'fs/promises'
import path from 'path'
import { fileURLToPath } from 'url'
import glob from 'tiny-glob'
import { mix, parseToHsl } from 'polished'

interface Colors {
  base00: string
  base01: string
  base02: string
  base03: string
  base04: string
  base05: string
  base06: string
  base07: string
  base08: string
  base09: string
  base0A: string
  base0B: string
  base0C: string
  base0D: string
  base0E: string
  base0F: string
}

interface ColorScheme {
  name: string
  colors: Colors
}

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const outdir = path.join(__dirname, 'colors')

async function main(): Promise<void> {
  const schemeFiles = await glob('**.y{a,}ml', {
    cwd: path.join(__dirname, 'colorschemes'),
  })
  const colorschemePaths = schemeFiles.map((p) =>
    path.resolve(__dirname, 'colorschemes', p),
  )

  await mkdir(outdir, { recursive: true })
  await Promise.all(colorschemePaths.map(processColorScheme))
}

async function readColorScheme(filePath: string): Promise<ColorScheme> {
  const text = await readFile(filePath, 'utf-8')
  let name = ''
  const colors = {} as Colors

  for (const rawLine of text.split('\n')) {
    const line = rawLine
      .replace(/^#.*$/, '')
      .replace(/\s+#.*$/, '')
      .trim()
    if (!line) continue

    const match = line.match(/([\w\d]+)\s*:\s*(.*)$/)
    if (!match) continue
    const [, key, val] = match
    const cleaned = val.replace(/^['"#]*/, '').replace(/['"]$/, '')

    if (key === 'scheme') {
      name = cleaned
    } else if (key.startsWith('base')) {
      ;(colors as any)[key] = `#${cleaned}`
    }
  }

  return { name, colors }
}

async function processColorScheme(filePath: string): Promise<void> {
  const { name: rawName, colors } = await readColorScheme(filePath)
  const name = rawName
    .replace(/\s+/g, '_')
    .replace(/[^\w\d]/g, '')
    .toLowerCase()

  const vimtxt = await generateVimText({ name: rawName, colors }, name)
  await writeFile(path.join(outdir, `${name}.vim`), vimtxt)
}

async function generateVimText(
  scheme: ColorScheme,
  vimName: string,
): Promise<string> {
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
  } = scheme.colors

  let file = [
    'set bg=dark',
    'hi clear',
    'syntax reset',
    `let colors_name = "${vimName}"`,
    '',
  ].join('\n')

  const highlight = (
    group: string,
    guifg: string,
    guibg: string,
    gui = '',
    guisp = '',
  ) => {
    let line = `hi ${group}`
    if (guifg) line += ` guifg=${guifg}`
    if (guibg) line += ` guibg=${guibg}`
    if (gui) line += ` gui=${gui}`
    if (guisp) line += ` guisp=${guisp}`
    file += line + '\n'
  }

  // core highlights
  highlight('Normal', base05, base00)
  highlight('Visual', '', base02)
  highlight('LspReferenceText', '', base01)
  highlight('LspReferenceRead', '', base01)
  highlight('LspReferenceWrite', '', base01)
  highlight('VertSplit', base02, base02, 'none')
  highlight('StatusLine', base04, base02, 'none')
  highlight('StatusLineNC', base03, base01, 'none')
  highlight('LineNr', base03, base00)
  highlight('CursorLineNr', base04, base00)
  highlight('Cursor', base00, base05)
  highlight('CursorLine', '', mix(0.15, base01, base00), 'none')
  highlight('ColorColumn', '', mix(0.15, base01, base00), 'none')
  highlight('SignColumn', base05, base01, 'none')
  highlight('NonText', base01, '')
  highlight('QuickFixLine', '', base01, 'none')
  highlight('Error', base00, base08)
  highlight('Underlined', base08, '')
  highlight('Title', base0D, '', 'none')
  highlight('TabLine', base04, base00, 'none')
  highlight('TabLineFill', base03, base00, 'none')
  highlight('TabLineSel', base05, base01, 'bold')
  highlight('MatchParen', '', base02)
  highlight('Directory', base0D, '')
  highlight('IncSearch', base01, base09, 'none')
  highlight('Search', base01, base0A)
  highlight('Comment', base03, '', 'italic')
  highlight('Delimiter', mix(0.5, base03, base05), '')
  highlight('String', base0B, '')
  highlight('Statement', base0E, '', 'none')
  highlight('StorageClass', base0E, '', 'none')
  highlight('Type', base0A, '', 'none')
  highlight('Operator', base0E, '', 'none')
  highlight('Identifier', base08, '')
  highlight('Special', base0C, '')
  highlight('Constant', base09, '')
  highlight('PreProc', base0A, '')
  highlight('Function', base0D, '')
  highlight('xmlTag', base05, '')
  highlight('xmlEndTag', base05, '')
  highlight('xmlTagName', base0D, '')
  highlight('xmlTagN', base0D, '')
  highlight('xmlAttrib', base0F, '')
  highlight('SpellBad', '', '', 'undercurl', base08)
  highlight('SpellLocal', '', '', 'undercurl', base0C)
  highlight('SpellCap', '', '', 'undercurl', base0D)
  highlight('SpellRare', '', '', 'undercurl', base0E)

  // diagnostics
  highlight('DiagnosticError', base08, '')
  highlight('DiagnosticUnderlineError', '', '', 'undercurl', base08)
  highlight('DiagnosticWarn', base09, '')
  highlight('DiagnosticUnderlineWarn', '', '', 'undercurl', base09)
  highlight('DiagnosticHint', base0B, '')
  highlight('DiagnosticUnderlineHint', '', '', 'undercurl', base0B)
  highlight('DiagnosticInfo', base0D, '')
  highlight('DiagnosticUnderlineInfo', '', '', 'undercurl', base0D)

  // diff base
  const greenest = findClosest(scheme.colors, '#74a14f')
  const reddest = findClosest(scheme.colors, 'red')
  const diffAdd = mix(0.2, greenest, base00)
  const diffDeletedLine = mix(0.2, reddest, base00)
  const diffChange = mix(0.25, base0D, base00)

  highlight('DiffAdd', '', diffAdd, 'none')
  highlight('DiffChange', '', base00)
  highlight('DiffDelete', diffDeletedLine, diffDeletedLine, 'none')
  highlight('DiffText', '', diffAdd, 'none')

  // neogit highlights
  highlight('NeogitDiffContext', base05, base00)
  highlight('NeogitDiffAdd', greenest, base00)
  highlight('NeogitDiffDelete', reddest, base00)

  highlight('NeogitDiffContextHighlight', base05, base00)
  highlight('NeogitDiffAddHighlight', greenest, base00)
  highlight('NeogitDiffDeleteHighlight', reddest, base00)

  highlight('NeogitHunkHeader', base05, base01)
  highlight('NeogitHunkHeaderHighlight', base05, base01)

  // fugitive diff as well
  highlight('DiffAdded', greenest, base00)
  highlight('DiffFile', reddest, base00)
  highlight('DiffNewFile', greenest, base00)
  highlight('DiffLine', base0D, base00)
  highlight('DiffRemoved', reddest, base00)

  // signify signs
  highlight('SignifySignAdd', greenest, diffAdd)
  highlight('SignifySignChange', base0D, diffChange)
  highlight('SignifySignDelete', reddest, '', 'underline')
  highlight('SignifySignDeleteFirstLine', reddest, '')

  // treesitter
  highlight('@markup.heading', base0D, '', 'bold')
  highlight('@markup.list', base08, '')
  highlight('@markup.italic', '', '', 'italic')
  highlight('@markup.strong', '', '', 'bold')
  highlight('@markup.strikethrough', reddest, base00)
  highlight('@markup.underline', greenest, base00)
  highlight('@markup.link.url', '', '', 'underline')

  highlight('PMenu', base05, base01)
  highlight('PMenuSel', base01, base05)

  highlight('Todo', base0A, base01)
  highlight('Folded', base03, base01)
  highlight('FoldColumn', base03, base00)

  file +=
    `
let g:terminal_color_0  = "${base00}"
let g:terminal_color_1  = "${base08}"
let g:terminal_color_2  = "${base0B}"
let g:terminal_color_3  = "${base0A}"
let g:terminal_color_4  = "${base0D}"
let g:terminal_color_5  = "${base0E}"
let g:terminal_color_6  = "${base0C}"
let g:terminal_color_7  = "${base05}"
let g:terminal_color_8  = "${base03}"
let g:terminal_color_9  = "${base08}"
let g:terminal_color_10 = "${base0B}"
let g:terminal_color_11 = "${base0A}"
let g:terminal_color_12 = "${base0D}"
let g:terminal_color_13 = "${base0E}"
let g:terminal_color_14 = "${base0C}"
let g:terminal_color_15 = "${base07}"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
` + '\n'

  return file
}

function findClosest(colors: Colors, targetColor: string): string {
  const palette = Object.values(colors).slice(8)
  const target = parseToHsl(targetColor)
  let closest = palette[0]
  let bestDiff = Number.POSITIVE_INFINITY

  for (const col of palette) {
    const h = parseToHsl(col)
    const diff = Math.min(
      Math.abs(h.hue - target.hue),
      Math.abs(h.hue - (360 + target.hue)),
    )
    if (diff < bestDiff) {
      bestDiff = diff
      closest = col
    }
  }

  return closest
}

main().catch(console.error)
