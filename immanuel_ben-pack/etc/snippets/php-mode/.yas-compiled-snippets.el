;;; Compiled snippets and support files for `php-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'php-mode
                     '(("array" "array(${[mixed ...]})$0" "array(...)" nil nil nil nil nil nil)
                       ("case" "case ${condition}:\n  $0\n  break;\n" "case ...: ... break;" nil nil nil nil nil nil)
                       ("class" "class ${class_name} {\n   public function __construct() {\n      $0\n   }\n}" "class ... " nil nil nil nil nil nil)
                       ("err" "error_log(${1:someMessage});$0\n" "err" nil nil nil nil nil nil)
                       ("e" "error_log(print_r(${1:someArray}, true));$0\n" "erra" nil nil nil nil nil nil)
                       ("for" "for (${initial}; ${condition}; ${next}) {\n   $0\n}\n" "for (...) {...}" nil nil nil nil nil nil)
                       ("foreach" "foreach (${collection} as ${var}) {\n   $0\n}" "foreach (...) {...}" nil nil nil nil nil nil)
                       ("funct" "function ${function_name}(${function_args})\n{\n   $0\n}" "funct ...(...)" nil nil nil nil nil nil)
                       ("function" "function ${function_name}(${function_args})\n{\n   $0\n}" "function ...(...)" nil nil nil nil nil nil)
                       ("if" "if (${condition}) {\n   $0\n}\n" "if (...) {...}" nil nil nil nil nil nil)
                       ("ifelse" "if (${condition}) {\n   ${consequent}\n}\nelse {\n   $0\n}" "if (...) {...} else { ... }" nil nil nil nil nil nil)
                       ("trim" "trim(${str[, string charlist]})$0" "trim(...)" nil nil nil nil nil nil)
                       ("try" "try {\n  $0\n}" "try { ... }" nil nil nil nil nil nil)
                       ("var.dump" "var_dump(${expression[, mixed expression]})$0" "var_dump(...)" nil nil nil nil nil nil)
                       ("while" "while (${condition}) {\n   $0\n}\n" "while (...) {...}" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed Oct 15 19:14:08 2014
