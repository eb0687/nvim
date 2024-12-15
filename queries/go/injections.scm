((
  (raw_string_literal_content) @constant
  (#match? @constant "(SELECT|select|insert|INSERT|UPDATE|update|DELETE|delete).*")
)@injection.content (#set! injection.language "sql"))
