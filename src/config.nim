import yaml.serialization, yaml.parser, options, streams, strutils, sequtils

type 
  RawConfig* = object
    shell   : string 
    profile : string
    workdir : string
    tabs    : seq[string]

  Shell* = enum 
    Bash, Fish

  Config* = object
    shell*   : Shell
    profile* : string
    workdir* : string
    tabs*    : seq[seq[string]]

setDefaultValue(RawConfig, shell, "bash")
setDefaultValue(RawConfig, profile, "")
setDefaultValue(RawConfig, workdir, "")

proc ok(raw_config: RawConfig) : Config {.raises: [ValueError].} =
  var shell: Shell
  var raw_shell: string
  try:
    if raw_config.shell != "fish" and raw_config.shell != "bash":
      raise newException(ValueError, "shell is not supported")
    elif raw_config.shell == "fish":
      shell = Fish
    else:
      shell = Bash
  except UnpackError:
    shell = Bash # default shell
  var config = Config(
    shell   : shell, 
    profile : raw_config.profile, 
    workdir : raw_config.workdir, 
    tabs    : raw_config.tabs.map(proc(x: string): seq[string] = x.split(Newlines).map(
      proc(y: string): string = y.strip(chars=Whitespace)).filter(
        proc(y: string): bool = len(y) > 0)))
  return config

proc loadConfig*(f: string): Config {.raises: [YamlConstructionError, IOError, YamlParserError, Exception].}=
  var raw_config: RawConfig
  var s = newFileStream(f)
  load(s, raw_config)
  s.close()
  return ok(raw_config)
