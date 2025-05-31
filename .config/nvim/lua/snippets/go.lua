local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- main function
	s(
		"main",
		fmt(
			[[
    func main() {{
      {}
    }}
  ]],
			{ i(0) }
		)
	),

	-- function
	s(
		"fn",
		fmt(
			[[
    func {}({}) {} {{
      {}
    }}
  ]],
			{
				i(1, "name"),
				i(2, "params"),
				i(3, "returnType"),
				i(0),
			}
		)
	),

	-- error handling
	s(
		"ife",
		fmt(
			[[
    if err != nil {{
      return {}
    }}
  ]],
			{ i(0, "err") }
		)
	),

	-- fmt.Println
	s("pl", fmt([[fmt.Println({})]], { i(0) })),

	-- fmt.Printf
	s(
		"pf",
		fmt([[fmt.Printf("{}", {})]], {
			i(1, "format"),
			i(2, "vars"),
		})
	),

	-- struct definition
	s(
		"struct",
		fmt(
			[[
    type {} struct {{
      {}
    }}
  ]],
			{
				i(1, "Name"),
				i(2, "// fields"),
			}
		)
	),

	-- interface
	s(
		"iface",
		fmt(
			[[
    type {} interface {{
      {}
    }}
  ]],
			{
				i(1, "Name"),
				i(2, "// methods"),
			}
		)
	),

	-- for loop
	s(
		"forr",
		fmt(
			[[
    for {} := {}; {} < {}; {}++ {{
      {}
    }}
  ]],
			{
				i(1, "i"),
				i(2, "0"),
				rep(1),
				i(3, "n"),
				rep(1),
				i(0),
			}
		)
	),

	-- go routine
	s(
		"go",
		fmt(
			[[
    go func() {{
      {}
    }}()
  ]],
			{ i(0) }
		)
	),
}
