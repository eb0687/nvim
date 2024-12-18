; extends

((
  (string_fragment) @constant
  (#match? @constant "html-injection")
)@injection.content (#set! injection.language "html"))

((
  (string_fragment) @constant
  (#match? @constant "<")
)@injection.content (#set! injection.language "html"))

; TODO: needs more work to be universal
; (
;  (comment) @constant
;  (#match? @constant "html")
;  (template_string (string_fragment) @injection.content (#set! injection.language "html"))
;  )

; TODO: need to test this
(
    (comment) @comm
    (#match? @comm "GraphQL")
    (template_string (string_fragment) @injection.content  (#set! injection.language "graphql"))
)



