import config, strutils

proc begin_of(config: Config): string =
  case config.shell:
  of Bash:
    result = ""
  of Fish:
    result = "fish -c \""
    if config.workdir != "":
      result &= "cd " & config.workdir & ";"

proc end_of(config: Config): string =
  case config.shell:
  of Bash:
    result = ""
  of Fish:
    result = "fish\""

proc generateProfile(profile: string): string =
  if profile == "":
    result = ""
  else:
    result = " --profile=" & profile
proc generateScript*(config: Config): string =
  var binary = "gnome-terminal"
  var profile = generateProfile(config.profile)
  var options = "--maximize" & profile

  var tabs: seq[string] = @[]
  var begin = begin_of(config)
  var endCommand = end_of(config)
  for tab in config.tabs:
    echo tab
    var c = ""
    c &= begin
    for command in tab:
      c &= command & ";and "
    c &= endCommand
    tabs.add(" --tab -e '" & c & "'")



  return binary & " " & options & " " & tabs.join(" ")

