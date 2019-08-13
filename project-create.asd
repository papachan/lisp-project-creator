;;;; project-create.asd

(asdf:defsystem #:cookbook
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :serial t
  :components ((:module "src"
                :serial t
                :components
                ((:file "functions"))))
  :description "")


(asdf:defsystem #:project-create
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :serial t
  :depends-on (:cl-mustache
               :cl-fad
               :str
               :cookbook)
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "main"))))
  :description "Generate a scaffold structure for a customized lisp project")
