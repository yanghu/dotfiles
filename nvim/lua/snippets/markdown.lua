local k = require("luasnip.nodes.key_indexer").new_key
return {
	-- Hugo shortcode
	-- Expands to {{< codename params >}} [inner] {{< /codename >}}
	-- The "Inner" and closing parts are optional and can be selected with c-e to
	-- toggle between choices.
	s(
		{ trig = "sc", name = "Hugo Shortcodes", dscr = "Hugo shortcodes" },
		fmt(
			[[
	{{<< <> <> >>}} <>]],
			{
				i(1, "shortcode", { key = "codename" }),
				i(2, "parameters"),
				c(3, {
					t(""),
					sn(nil, {
						i(1, "inner"),
						t(" {{< /"),
						rep(k("codename")),
						t(" >}}"),
					}),
				}),
			},
			{ delimiters = "<>" }
		)
	),
}
