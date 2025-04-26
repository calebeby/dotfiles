#!/usr/bin/env -S deno run --allow-net --allow-write --allow-env --allow-read

import prompts from 'https://esm.sh/prompts@2.4.2'
import { join } from 'https://deno.land/std@0.177.0/path/mod.ts'

const extractThemes = (html: string) => {
  const titleRegex = /<div class="window_title__[^"]+">([^<]+)<\/div>/g
  const colorRegex = /--colorscheme-(\S+?):(#[^;"']+)/g

  const titles = []
  const counts: Record<string, number> = {}

  let titleMatch
  while ((titleMatch = titleRegex.exec(html)) !== null) {
    let title = titleMatch[1]
    if (counts[title]) {
      title = `${title} ${counts[title]}`
      counts[title] += 1
    } else {
      counts[title] = 1
    }
    titles.push({ name: title, index: titleMatch.index })
  }

  const themes = []
  let colorMatch
  let currentTheme = { name: titles[0]?.name || 'Unknown', colors: {} }
  let titleIdx = 0

  while ((colorMatch = colorRegex.exec(html)) !== null) {
    const currentIndex = colorMatch.index

    if (titleIdx < titles.length && currentIndex > titles[titleIdx].index) {
      themes.push(currentTheme)
      titleIdx++
      currentTheme = { name: titles[titleIdx].name, colors: {} }
    }

    const [_, colorName, colorValue] = colorMatch
    currentTheme.colors[colorName] = colorValue.toLowerCase()
  }

  // Push the last theme
  themes.push(currentTheme)

  return themes
}

const toBase16 = (themeName: string, colors: Record<string, string>) => {
  const mapping = {
    base00: colors.NormalBg,
    base01: colors.StatusLineBg,
    base02: colors.CursorLineBg,
    base03: colors.vimLineCommentFg,
    base04: colors.StatusLineFg || colors.LineNrFg,
    base05: colors.NormalFg,
    base06: colors.CursorBg,
    base07: colors.CursorFg,
    base08: colors.vimVarFg,
    base09: colors.vimNumberFg,
    base0A: colors.vimFuncModFg,
    base0B: colors.vimStringFg,
    base0C: colors.vimFuncParamFg,
    base0D: colors.vimFuncNameFg,
    base0E: colors.vimNotFuncFg,
    base0F: colors.vimLetFg,
  }

  let yaml = `scheme: "${themeName}"\nauthor: "Unknown"\n`
  for (const [key, value] of Object.entries(mapping)) {
    yaml += `${key}: "${value}"\n`
  }
  return yaml
}

const { repo } = await prompts({
  type: 'text',
  name: 'repo',
  message: 'Enter the theme repo (e.g., dracula/vim):',
})

const response = await fetch(`https://vimcolorschemes.com/${repo}`)
const html = await response.text()

const themes = extractThemes(html)

const { selectedThemes } = await prompts({
  type: 'autocompleteMultiselect',
  name: 'selectedThemes',
  message: 'Select subthemes to export:',
  choices: themes.map((theme) => ({ title: theme.name, value: theme })),
  min: 1,
})

for (const theme of selectedThemes) {
  const yaml = toBase16(theme.name, theme.colors)
  const filename = join(
    Deno.cwd(),
    'colorschemes',
    `${theme.name.toLowerCase().replace(/\s+/g, '_')}.yaml`,
  )
  await Deno.writeTextFile(filename, yaml)
  console.log(`Saved ${filename}`)
}

await import('./build.ts')
Deno.exit(0)
