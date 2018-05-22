const fs = require('fs')
const path = require('path')
const map = require('async/map')
const { promisify } = require('util')

const readFile = promisify(fs.readFile)
const writeFile = promisify(fs.writeFile)

async function processFile(filepath) {
  const contents = await loadFile(filepath)
  return await processIncludes(contents, filepath) }

async function loadFile(filepath) {
  const buffer = await readFile(filepath)
  return buffer.toString() 
}

function tokenize(data, filepath) {
  let scope = 0
  const tokens = []
  data.split('\n').forEach((line, i) => {
    if (line.startsWith('include')) {
      const file = line.split(`"`)[1]
      const dir = path.dirname(filepath)
      tokens.push({
        type: 'include',
        row: i,
        path: `${dir}/${file}`,
        scope
      })
    } else {
      line.split('').forEach((char, j) => {
        if ( char === "{" ) {
          scope += 1
          tokens.push({
            type: 'scopedown',
            row: i,
            col: j,
            scope
          })
        }
        if ( char === "}" ) {
          scope -= 1
          tokens.push({
            type: 'scopeup',
            row: i,
            col: j,
            scope
          })
        }
      })
    }
  })
  return tokens
}

async function processIncludes(data, filepath) {
  const tokens = tokenize(data, filepath)
  const included = []
  for ( i of tokens ) {
    included.push(await loadFile(i.path))
  }

  const processed = [
    data.split('\n').filter(i => !i.startsWith('include')).join('\n'),
    included.join('\n')
  ].join('\n')

  return processed
}


module.exports = {
  loadFile, processFile
}
