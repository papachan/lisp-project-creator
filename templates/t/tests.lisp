;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; tests.lisp
(in-package :{{project_name}}-test)

(def-suite all-tests :description "some dummy tests")

(in-suite all-tests)

;; to be removed
(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))

;; to be removed
(test test-+
  "Test the + function"
  (is (= 0 (+ 0 0)))
  (is (= 4 (+ 2 2)))
  (is (= 1/2 (+ 1/4 1/4))))

;; to be removed
(test test-main-function
  "testing calling a function from main.lisp"
  (is (equal "(1 2)" (hello))))

(run! 'all-tests)

(print "tests ends")
