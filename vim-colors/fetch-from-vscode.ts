#!/usr/bin/env -S deno run --allow-net --allow-write --allow-env --allow-read

import prompts from 'https://esm.sh/prompts@2.4.2'
import { unzipSync, strFromU8 } from 'https://esm.sh/fflate@0.8.2'
import { join } from 'https://deno.land/std@0.201.0/path/mod.ts'
import { parse } from 'https://deno.land/std@0.220.1/jsonc/mod.ts'

const { url } = await prompts({
  type: 'text',
  name: 'url',
  message: 'VSCode Package URL',
})

// const url =
//   'https://marketplace.visualstudio.com/items?itemName=RobbOwen.synthwave-vscode'

const match =
  /^https:\/\/marketplace.visualstudio.com\/items\?itemName=(?<publisher>[^\.]*).(?<pkg>[^\.]*)$/.exec(
    url,
  )

if (!match || !match.groups) throw new Error('unrecognized url')
const { publisher, pkg } = match.groups

const zipURL = `https://${publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${pkg}/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage`

const res = await fetch(zipURL)
const zipData = new Uint8Array(await res.arrayBuffer())

const files = unzipSync(zipData)

const pkgJson = parse(strFromU8(files['extension/package.json']))

function colorize(hex: string) {
  const m = hex.replace(/^#/, '').match(/.{1,2}/g)
  if (!m) throw new Error('Invalid hex code')
  const [r, g, b] = m.map((v) => parseInt(v, 16))
  return `\x1b[48;2;${r};${g};${b}m${hex}\x1b[0m`
}

for (const themeMetadata of pkgJson?.contributes?.themes) {
  const themeName = themeMetadata.label.replace(/\s+/g, ' ')
  const themeJSON = parse(
    strFromU8(files[join('extension', themeMetadata.path)]),
  )

  const normalize = (c: unknown) => {
    if (typeof c !== 'string') return c
    if (c.startsWith('#')) {
      return c.slice(0, 7).toLowerCase() // cut off alpha values
    } else {
      return c
    }
  }

  // let allColors = new Set(
  //   [
  //     ...Object.values(themeJSON.colors),
  //     ...themeJSON.tokenColors.map((k) => k.settings.foreground).filter(Boolean),
  //   ].map(normalize),
  // )

  const getScopeColor = (name: string) => {
    const v = themeJSON.tokenColors.findLast((s: any) =>
      Array.isArray(s.scope) ? s.scope?.includes(name) : s.scope === name,
    )?.settings?.foreground
    if (!v) return null
    return normalize(v)
  }

  // await Deno.writeTextFile('foo.json', JSON.stringify(themeJSON, null, 2))

  const base00 = normalize(themeJSON.colors['editor.background']) // Default Background
  const base01 = normalize(themeJSON.colors['statusBar.background']) // Lighter Background (Used for status bars line number and folding marks)
  const base02 = normalize(
    themeJSON.colors['selection.background'] ??
      themeJSON.colors['editor.selectionBackground'],
  ) // Selection Background
  const base03 = getScopeColor('comment') // Comments, Invisibles, Line Highlighting
  const base04 = normalize(
    themeJSON.colors['statusBar.foreground'] ?? themeJSON.colors['foreground'],
  ) // Dark Foreground (Used for status bars)
  const base05 = normalize(
    themeJSON.colors['editor.foreground'] ?? themeJSON.colors['foreground'],
  ) // Default Foreground, Caret, Delimiters, Operators
  const base06 = normalize(themeJSON.colors['dropdown.foreground'] ?? base05) // Light Foreground (Not often used)
  const base07 = normalize(themeJSON.colors['dropdown.background'] ?? base05) // Light Background (Not often used)
  const base08 =
    getScopeColor('entity.name.variable') ??
    getScopeColor('variable') ??
    getScopeColor('entity.name.tag') // Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  const base09 =
    getScopeColor('constant.numeric') ??
    getScopeColor('constant.language.boolean')
  const base0A =
    getScopeColor('support.type') ??
    getScopeColor('storage.type') ??
    getScopeColor('entity.name.type') // Classes, Markup Bold, Search Text Background
  const base0B =
    getScopeColor('string') ??
    getScopeColor('string.quoted') ??
    getScopeColor('string.template')
  const base0C =
    getScopeColor('constant.character.escape') ??
    getScopeColor('string.regexp') ??
    getScopeColor('variable.language.special') // Support, Regular Expressions, Escape Characters, Markup Quotes
  const base0D = getScopeColor('entity.name.function') // Functions, Methods, Attribute IDs, Headings
  const base0E = getScopeColor('keyword') // Keywords, Storage, Selector, Markup Italic, Diff Changed
  const base0F = getScopeColor('entity.other.attribute-name') // Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  const colors = {
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
  }

  const targetFileName = `${themeName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}.yaml`

  const fileText = `scheme: ${JSON.stringify(themeName)}
author: ${JSON.stringify(publisher)}
${Object.entries(colors)
  .map(([name, color]) => {
    if (!color) throw new Error(`missing color ${name} for ${themeName}`)
    return `${name}: ${JSON.stringify(color)}`
  })
  .join('\n')}`

  console.log(themeName)

  console.log(
    Object.entries(colors)
      .map(([name, color]) => {
        if (!color) throw new Error(`missing color ${name} for ${themeName}`)
        return `${name}: ${color && colorize(color)}`
      })
      .join('\n'),
  )

  const filePath = join('colorschemes', targetFileName)
  console.log(`Writing ${filePath}`)

  await Deno.writeTextFile(filePath, fileText)
}
