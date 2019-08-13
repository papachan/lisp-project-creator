;;;; {{project_name}}-test.asd

(asdf:defsystem #:{{project_name}}-test
  :author ""
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
