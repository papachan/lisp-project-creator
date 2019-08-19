;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; main.lisp

(in-package #:{{project_name}})

(defun hello ()
  (format nil "~A" '(1 2)))

(format t ";;; Done~%")
