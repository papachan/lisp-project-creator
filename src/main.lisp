;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; main.lisp

(in-package #:project-create)

(defvar *project-directory*
  (asdf:system-relative-pathname :project-create ""))

(defun hello ()
  (format t "~A" '(1 2)))

(defun main ()
  (hello))
