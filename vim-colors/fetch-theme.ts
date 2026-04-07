#!/usr/bin/env -S deno run --allow-net --allow-write --allow-env --allow-read --allow-sys --allow-run

import prompts from "https://esm.sh/prompts@2.4.2";
import { join } from "https://deno.land/std@0.177.0/path/mod.ts";
import puppeteer from "npm:puppeteer";

const toTitleCase = (str: string) => {
  return str.toLowerCase().replace(/\b\w/g, (char) => char.toUpperCase());
};

const toBase16 = (
  schemeName: string,
  colors: Record<string, string>,
  author: string,
  debugURL: string,
) => {
  const mapping = {
    base00: colors.NormalBg,
    base01: colors.StatusLineBg,
    base02: colors.CursorLineBg ?? colors.StatusLineBg,
    base03: colors.vimLineCommentFg,
    base04: colors.StatusLineFg ?? colors.LineNrFg,
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
  };

  let yaml = `scheme: "${schemeName}"\nauthor: "${author}"\n`;
  for (const [key, value] of Object.entries(mapping)) {
    if (!value) throw new Error(`Missing: ${key} (check ${debugURL})`);
    yaml += `${key}: "${value.toLowerCase()}"\n`;
  }
  return yaml;
};

const { query } = await prompts({
  type: "text",
  name: "query",
  message: "Search for a theme (e.g., iceberg):",
});

// Does not work if I use fetch, even if I copy all the headers exactly.
// Has to be a real browser.

const browser = await puppeteer.launch({
  headless: true, // Set to false if you want to watch it work
  args: ["--no-sandbox"],
});

const apiURL = `https://vimcolorschemes.com/api/repositories?search=${encodeURIComponent(query)}`;
const response = await (await browser.newPage()).goto(apiURL);
const data = await response?.json();
await browser.close();

const { selectedRepo } = await prompts({
  type: "select",
  name: "selectedRepo",
  message: "Which repository:",
  choices: data.repositories.map((repo: any) => ({
    title: `${repo.name} (${repo.owner.name})`,
    value: repo,
  })),
});

if (!selectedRepo) Deno.exit(0);

const { selectedThemes } = await prompts({
  type: "autocompleteMultiselect",
  name: "selectedThemes",
  message: "Select subthemes to export:",
  choices: selectedRepo.vimColorSchemes.flatMap((theme: any) => {
    return Object.entries(theme.data).flatMap(([background, value]) => {
      if (!value) return [];
      const name = toTitleCase(
        theme.backgrounds.length === 1
          ? theme.name
          : `${theme.name} ${background}`,
      );
      return {
        title: name,
        value: { colors: value, name },
      };
    });
  }),
  min: 1,
});

for (const theme of selectedThemes) {
  const yaml = toBase16(
    theme.name,
    Object.fromEntries(theme.colors.map((d) => [d.name, d.hexCode])),
    selectedRepo.owner.name,
    apiURL,
  );
  const filename = join(
    Deno.cwd(),
    "colorschemes",
    `${theme.name.toLowerCase().replace(/\s+/g, "_")}.yaml`,
  );
  await Deno.writeTextFile(filename, yaml);
  console.log(`Saved ${filename}`);
}

await import("./build.ts");
