;;;; {{project_name}}.asd

(asdf:defsystem #:{{project_name}}-test
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :depends-on (:fiveam)
  :serial t
  :components (
               (:module "t"
                :serial t
                :components
                ((:file "package")
                 (:file "tests"))))
  :description "")
