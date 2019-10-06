# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.
import os
import CSS2NIMDSL/Token

# 입력: default.css
# 출력: default.nimdsl
const CSS_PATH = "./static/default.css"
var OUTPUT_PATH =  "./static/default.nimdsl"

# default.css 파일읽기
proc readCSS(path: string): string =
  return readFile(path)
  # echo fileContent

# TODO: default.nimdsl 파일쓰기
proc writeDSL(fileContent: string) =
  writeFile(OUTPUT_PATH, fileContent)

import parseopt
# CLI arg로 파일명 받기
proc parseOption() =
  # cmd prototype: css2nimdsl ./default.css -o:./default.nimdsl
  var inputPath = ""
  for kind, key, val in getOpt():
      case kind
      of cmdArgument: # Argument such as filename.
          inputPath = key
      of cmdLongOption, cmdShortOption: # longOption such as --option, shortOption such as -c.
          case key 
          of "port": 
              echo "Got port: ", val
          of "o":
              OUTPUT_PATH = val
          else: 
              echo "Got another flag --", key, " with value: ", val
      of cmdEnd: discard

when isMainModule:
  var contents = readCSS(CSS_PATH)
  writeDSL(contents)
  parseOption()
