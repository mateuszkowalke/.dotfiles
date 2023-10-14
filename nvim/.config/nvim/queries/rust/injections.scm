; query! sqlx macro
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query")
  )
  (token_tree (raw_string_literal) @sql)
)

; query_as! sqlx macro
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query_as")
  )
  (token_tree (raw_string_literal) @sql)
)
