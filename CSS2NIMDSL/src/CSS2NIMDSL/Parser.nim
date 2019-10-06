# import macros

import Token
import Lexer
import AST

type Parser* = ref object of RootObj
  l : Lexer
  curToken : Token
  peekToken : Token

proc nextToken(p: Parser) =
  p.curToken = p.peekToken
  p.peekToken = p.l.nextToken()

method ParseProgram*(p: Parser): Program =
  result = NewProgram()

proc NewParser*(l: Lexer): Parser =
  let p = Parser(l: l)
  # 2개의 토큰들을 읽어서 curToken과 peekToken 초기화.
  p.nextToken()
  p.nextToken()
  result = p

# nim c -r ./src/CSS2NIMDSL/Parser.nim
