(defpackage #:defnt/test
  (:use #:cl
        #:rove
        #:defnt))
(in-package #:defnt/test)

;; (eval-when (:compile-toplevel :load-toplevel :execute)
;;   (require "sb-introspect"))

;; (defmacro signals* (form condition error-message)
;;   ;; TODO: 似たようなユーティリティを色々な箇所でコピペしているのでroveに反映したい
;;   (with-unique-names (outer c)
;;     `(block ,outer
;;        (handler-bind ((condition (lambda (,c)
;;                                    (when (typep ,c ,condition)
;;                                      (return-from ,outer
;;                                        (equal ,error-message
;;                                               (princ-to-string ,c)))))))
;;          ,form
;;          nil))))

;; ;;;
;; (define-defnt func-ordinary-1 (:inputs ((a fixnum) (b fixnum)))
;;   (+ a b))

;; (deftest func-ordinary
;;   (ok (equal '(a b) (sb-introspect:function-lambda-list 'func-ordinary-1)))
;;   (ok (= 30 (func-ordinary-1 10 20)))
;;   (ok (signals* (func-ordinary-1 1.0 10)
;;                 'strict-invalid-input
;;                 "input value 1.0 is not of type FIXNUM: A"))
;;   (ok (signals* (func-ordinary-1 100 2.0)
;;                 'strict-invalid-input
;;                 "input value 2.0 is not of type FIXNUM: B")))
