const fs = require('fs')
const path = require('path')
const map = require('async/map')
const { promisify } = require('util')
const { flatten, uniq } = require('underscore')
const { spawn } = require('child_process')

const readFile = promisify(fs.readFile)

async function run(filepath, printToConsole = true) {
  return new Promise(async (resolve, reject) => {
    const { requires } = await processFile(filepath)  
    requires.push(filepath)


    const chuckProcess = spawn('chuck', requires)

    if ( printToConsole ) {
      chuckProcess.stdout.setEncoding('utf8')
      chuckProcess.stderr.setEncoding('utf8')

      chuckProcess.stdout.on('data', (chunk) => {
        console.log(chunk)
      })

      chuckProcess.stderr.on('data', (chunk) => {
        console.log(chunk)
      })
    }

    chuckProcess.on('close', (code) => {
      resolve(code)
    });
  })
}

async function generateChuckCommand(filepath) {
  const data = await processFile(filepath)  
  let command = data.requires.reduce((acc, val) => acc += `${val} `, "chuck ")
  command += filepath
  return command
}

async function processFile(filepath) {
  const contents = await loadFile(filepath)
  return {
    requires: await processRequires(contents, filepath)
  }
}

async function processRequires(data, filepath) {
  const tokens = tokenize(data, filepath)
  const requiredFiles = []
  for ( let i of tokens ) {
    if ( i.type == 'require' ) {
      let requiredFile = await loadFile(i.path)
      let requiredFilePath = i.path

      requiredFiles.push(await processRequires(
        requiredFile,
        requiredFilePath
      ))

      requiredFiles.push(i.path)
    }
  }

  return uniq(flatten(requiredFiles).map(p => path.normalize(p)))
}

async function loadFile(filepath) {
  const buffer = await readFile(filepath)
  return buffer.toString() 
}

function tokenize(data, filepath) {
  let scope = 0
  const tokens = []
  data.split('\n').forEach((line, i) => {
    if ( line.startsWith('// require') ) {
      tokens.push({
        type: 'require',
        path: splitPathFromParens(line, filepath),
      })
    }
  })
  return tokens
}

function splitPathFromParens(line, filepath) {
  if ( line.includes(`"`)) {
    const file = line.split(`"`)[1]
    const dir = path.dirname(filepath)
    return `${dir}/${file}`
  }
  const file = line.split(`'`)[1]
  const dir = path.dirname(filepath)
  return `${dir}/${file}`
}

module.exports = {
  loadFile,
  processFile,
  processRequires,
  generateChuckCommand,
  run
}
