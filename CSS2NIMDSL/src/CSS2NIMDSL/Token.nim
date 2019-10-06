# [CSS String] -----------------> [Tokenizer] ------> [Stream of Tokens]
#              |                       ^
#              `-----> [Parser] ------/
#                         |
#                         v 
#                       [AST]
import tables

type TokenType* = string

type Token* = tuple
    Type: TokenType
    Literal: string

const
    # PREPARING TOKEN
    EOF_TOKEN* = "EOF-TOKEN" 
    ILLEGAL_TOKEN* = "ILLEGAL-TOKEN" 
    IDENT_TOKEN* = "IDENT-TOKEN" 
    FUNCTION_TOKEN* = "FUNCTION-TOKEN"  # = IDENT_TOKEN + (
    STRING_TOKEN* = "STRING-TOKEN"  # "" , ''
    BAD_STRING_TOKEN* = "BAD-STRING-TOKEN" 
    URL_TOKEN* = "URL-TOKEN"  # = IDENT_TOKEN "url" + ()
    BAD_URL_TOKEN* = "BAD-URL-TOKEN"  
    DELIM_TOKEN* = "DELIM-TOKEN" 
    NUMBER_TOKEN* = "NUMBER-TOKEN" 
    # SINGLE CHARCTER TOKEN
    AT_KEYWORD_TOKEN* = "@"
    HASH_TOKEN* = "#"
    PERCENTAGE_TOKEN* = "%" 
    WHITESPACE_TOKEN* = " " # \t, newline
    # SPECIAL CHARACTER
    COLON_TOKEN* = ":"
    SEMICOLON_TOKEN* = ";" 
    COMMA_TOKEN* = ","
    # BLOCK
    LBLOCK_TOKEN* = "["
    RBLOCK_TOKEN* = "]"
    LPARAN_TOKEN* = "("
    RPARAN_TOKEN* = ")"
    LBRACE_TOKEN* = "{"
    RBRACE_TOKEN* = "}"
    # COMMENT
    CDO_TOKEN* = "<!--"
    CDC_TOKEN* = "-->"
    # KEYWORD
    DIMENSION_TOKEN* = "px"  # px, em
    ATTR_HEIGHT* = "height"
    HTML_BODY* = "body"

var KEYWORDS*: Table[string, TokenType] = {
    "<!--": CDO_TOKEN,
    "-->": CDC_TOKEN,
    "height": ATTR_HEIGHT,
    "px": DIMENSION_TOKEN
}.toTable

proc lookupIdent*(ident: string): TokenType =
    echo "ident: ", ident, "[END]", KEYWORDS.hasKey(ident)
    if KEYWORDS.hasKey(ident): 
        result = KEYWORDS[ident]
    else:
        result = IDENT_TOKEN

# References
# - CSS Syntax Module Level 3 (https://www.w3.org/TR/css-syntax-3)
# - CSSTree (https://github.com/csstree/csstree)