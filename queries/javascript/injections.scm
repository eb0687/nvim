; extends

; NOTE: not sure why this does not work
; ((call_expression
;    function: (identifier)
;    arguments: (arguments
;                 (comment) @injection.language
;                 (#eq? @injection.language "/*html*/")
;                 (template_string
;                   (string_fragment) @injection.content)))
;  (#set! injection.language "html")) ; Set the language of the string_fragment to HTML

((
  (string_fragment) @constant
  (#match? @constant "html-inject")
)@injection.content (#set! injection.language "html"))


