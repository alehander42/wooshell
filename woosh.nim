import osproc, parseopt2
import src/config, src/generator

proc usage(): void =
  echo "woosh <config>"

var f = ""

for kind, key, val in getopt():
  case kind
  of cmdArgument:
    f = key
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": usage()
    else: discard
  of cmdEnd: assert(false) # cannot happen

if f == "":
  usage()
else:
  try:
    let config = loadConfig(f)
    let script = generateScript(config)
    let status = execCmd(script)
    echo status
    echo script
  except Exception as e:
    echo e.msg
    quit(1)


