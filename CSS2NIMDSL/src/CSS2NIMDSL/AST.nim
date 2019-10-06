# FIXME: 인터페이스
type Statement = concept x
  x is distinct string

type Program* = ref object of RootObj
  stmts* : seq[string]

proc NewProgram*(): Program =
  let p = Program(stmts: @["nil"])
  result = p
