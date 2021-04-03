;;; Generic test framework using SRFI 78.
(import (srfi 1)
        (srfi 128)
        (srfi 158)
        (srfi 189)
        (srfi 224))

(cond-expand
  ((library (srfi 78))
   (import (srfi 78)))
  (else
    (begin
      (define *tests-failed* 0)
      (define-syntax check
        (syntax-rules (=>)
          ((check expr => expected)
           (if (equal? expr expected)
             (begin
               (display 'expr)
               (display " => ")
               (display expected)
               (display " ; correct")
               (newline))
             (begin
               (set! *tests-failed* (+ *tests-failed* 1))
               (display "FAILED: for ")
               (display 'expr)
               (display " expected ")
               (display expected)
               (display " but got ")
               (display expr)
               (newline))))))
      (define (check-report)
        (if (zero? *tests-failed*)
            (begin
             (display "All tests passed.")
             (newline))
            (begin
             (display "TESTS FAILED: ")
             (display *tests-failed*)
             (newline)))))))

;;; SRFI 64 shim

(define-syntax test-equal
  (syntax-rules ()
    ((_ expected expr)
     (check expr => expected))))

(define-syntax test-eqv
  (syntax-rules ()
    ((_ expected expr)
     (check expr (=> eqv?) expected))))

(define-syntax test-group
  (syntax-rules ()
    ((test-group name t ...)
     (begin
      (newline)
      (display ";;; Test group: ")
      (display name)
      (newline)
      (newline)
      t ...))))

(include "test-body.scm")
