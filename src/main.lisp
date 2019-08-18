;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; main.lisp

(in-package :project-create)

;; setup debun to nil when you make an image
(defconstant *debug* nil)

(defvar *templates-dir*
  (asdf:system-relative-pathname :project-create #P"templates"))

(defvar *local-directory*
  (if *debug*
      (pathname-parent-directory (asdf:system-relative-pathname :project-create ""))
      (make-pathname :directory '(:relative "."))))

(defun get-current-year ()
  (multiple-value-bind (s min h d m y) (decode-universal-time (get-universal-time))
    (declare (ignore s min h))
    y))

(defun copy-files (lst values)
  (loop :for n :in lst
        :do (with-open-file (output-stream (second n)
                                           :direction :output
                                           :if-exists :supersede
                                           :if-does-not-exist :create)
              (mustache:render (read-file-string (car n)) values output-stream)
              (format t "~A~%" (second n)))))

;; ask the project name
(defun main ()
  "Ask for a project name and create all files"
  (flet ((prompt (string)
           (format *query-io* "~a: " string)
           (force-output *query-io*)
           (read-line *query-io*)))
    (let* ((project-name (prompt "What is your project name?"))
           (project-root (merge-pathnames (concatenate 'string project-name "/")
                                          *local-directory*))
           (files '()))
      (progn
        ;; create directories
        (ensure-directories-exist project-root)

        (unless (directory-exists-p project-root)
          (error "~S does not exist." project-root))

        (ensure-directories-exist (merge-pathnames
                                   (concatenate 'string project-name "/t/")
                                   *local-directory*))

        (ensure-directories-exist (merge-pathnames
                                   (concatenate 'string project-name "/src/")
                                   *local-directory*))

        ;; update paths with new_path and new filename
        (walk-directory *templates-dir*
                        (lambda (path)
                          (let* ((templates-dir (asdf:system-relative-pathname :project-create "templates"))
                                 (len (length (namestring templates-dir)))
                                 (subpath (subseq (namestring path) len))
                                 (newpath (concatenate 'string (namestring *local-directory*) project-name subpath)))
                            (if (not (null (search "asd" (namestring path))))
                                (push (list path (replace-all newpath "project_name" project-name)) files)
                                (push (list path newpath) files)))))

        (copy-files files (list (cons :project_name project-name)
                                (cons :year (get-current-year))))
        (format t ";; DONE~%")))))


(print *local-directory*)

(main)

;; main.lisp ends here
