import Token

proc newToken(tokenType: TokenType, ch: char): Token =
  result = (Type: tokenType, Literal: $ch)

type Lexer* = ref object of RootObj
  input : string
  pos : int
  readPos : int
  ch : char

# Lexer Methods
method readCh*(self: Lexer) {.base.} =
  if self.readPos >= self.input.len:
    self.ch = '0'
  else:
    self.ch = self.input[self.readPos]
  self.pos = self.readPos
  self.readPos += 1

# 문자 판별
proc isLetter(ch: char): bool =
  'a' <= ch and ch <= 'z' or 'A' <= ch and ch <= 'Z' or ch == '_'
# 숫자 판별
proc isDigit(ch: char): bool =
  '0' <= ch and ch <= '9'

# 숫자 읽기
proc readNumber(self: Lexer): string =
  let pos = self.pos
  while isDigit(self.ch):
    self.readCh()
  result = self.input[pos .. self.pos-1]

# 식별자 읽기
method readIdentifier(self: Lexer): string {.base.} =
  let pos = self.pos
  while isLetter(self.ch):
    self.readCh()
  result = self.input[pos .. self.pos - 1]

method skipWhitespace(self: Lexer) {.base.} =
  while self.ch == ' ' or self.ch == '\t' or self.ch == '\n' or self.ch == '\r':
    self.readCh()

method nextToken*(self: Lexer): Token {.base.} =
  var tok: Token

  self.skipWhitespace()

  case self.ch
  of '@':
    tok = newToken(AT_KEYWORD_TOKEN, self.ch)
  of '#':
    tok = newToken(HASH_TOKEN, self.ch)
  of '%':
    tok = newToken(PERCENTAGE_TOKEN, self.ch)
  of ':':
    tok = newToken(COLON_TOKEN, self.ch)
  of ';':
    tok = newToken(SEMICOLON_TOKEN, self.ch)
  of ',':
    tok = newToken(COMMA_TOKEN, self.ch)
  of '[':
    tok = newToken(LBLOCK_TOKEN, self.ch)
  of ']':
    tok = newToken(RBLOCK_TOKEN, self.ch)
  of '(':
    tok = newToken(LPARAN_TOKEN, self.ch)
  of ')':
    tok = newToken(RPARAN_TOKEN, self.ch)
  of '{':
    tok = newToken(LBRACE_TOKEN, self.ch)
  of '}':
    tok = newToken(RBRACE_TOKEN, self.ch)
  else:
    echo "self.ch: ", self.ch, "[END]"
    echo "isLetter(self.ch): ", isLetter(self.ch)
    if isLetter(self.ch):
      tok.Literal = self.readIdentifier()
      tok.Type = lookupIdent(tok.Literal)
      result = tok
    elif isDigit(self.ch):
      tok.Type = NUMBER_TOKEN
      tok.Literal = self.readNumber()
      result = tok
    else:
      tok = newToken(ILLEGAL_TOKEN, self.ch)

  self.readCh()
  result = tok

# Lexer Constructor
proc NewLexer*(input: string): Lexer =
  let l = Lexer(input: input)
  l.readCh()
  result = l
