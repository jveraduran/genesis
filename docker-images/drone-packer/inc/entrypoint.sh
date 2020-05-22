#!/usr/bin/env node
const { spawn } = require('child_process')

const template = process.env.PLUGIN_TEMPLATE || 'config.json'
const vars = process.env.PLUGIN_VARS ? JSON.parse(process.env.PLUGIN_VARS) : []
const actions = process.env.PLUGIN_ACTIONS ? process.env.PLUGIN_ACTIONS.split(',') : []

let args = [];
args.push('build')
args.push('-force')


if(process.env.DEBUG) {
  console.log("Verbose mode is ON")
  process.env.PACKER_LOG = 1
} else {
  console.log("Verbose mode is ON")
}

for (var property in vars) {
  args.push('-var')
  args.push(`${property}=${vars[property]}`)
}
args.push(template)

const command = spawn('packer', args, Object.assign({USER:'root'}, process.env));

let log = (data) => {
  console.log(data.toString('utf8'))
}
command.stdout.on('data', log);
command.stderr.on('data', log);


let close = (code) => {
  console.log(`child process exited with code ${code}`);
  process.exit(code);
}
command.on('close', close);
