# This is the worst testing library ever, but we need to start somewhere
import "chalk" as chalk
import { deepEqual } from 'fast-equals'
let equal = deepEqual

# Have some kind of test runner class, not a global
let level = 0

export def log-indented(msg)
  let indent = "".padStart(level*2, )
  console.log(indent+msg)

export def test(msg, block)
  log-indented(msg)
  try
    level += 1
    block()
  catch e
    log-indented chalk.red("ERROR: {e}")
  level -=1

# JS is such a pile of garbage
let def to-string(x)
  let t = typeof(x)
  console.log("STR", t, x)
  if x === true || x === false || t === "string" || t === "number"
    JSON.stringify(x)
  else if Array.isArray(x)
    "[" + x.map(do |el| to-string(el)).join(", ") + "]"
  else if x instanceof Map
    let entries = Array.from(x.entries)
    "Map.new([" + entries.map(do |k,v| "[{to-string(k)}, {to-string(v)}]").join(", ") + "])"
  else if x instanceof Set
    let entries = Array.from(x.entries)
    "Set.new([" + entries.map(do |el| "{to-string(el)}").join(", ") + "])"
  else if t === "object"
    "\{" + Object.entries(x).map(do |k,v| "{to-string(k)}: {to-string(v)}").join(", ") + "\}"
  else
    # JS is horrible
    console.log "Javascript is horrible garbage: {t} {JSON.stringify(x)}"
    JSON.stringify(x)

export def assert-eq(a, b)
  if equal(a, b)
    log-indented chalk.green("OK")
  else
    log-indented chalk.red("FAIL: {to-string(a)} != {to-string(b)}")
