(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

; +
(define (MULT m i)
  (display "1"))
;  (vector-set! m (fourth i) (+ (vector-ref m (second i)) (vector-ref m (third i)))))

; *
(define (ADD m i)
  (display "2"))
;  (vector-set! m (fourth i) (* (vector-ref m (second i)) (vector-ref m (third i)))))

; set
(define (SET m i)
  (display "3"))

; output
(define (DISP m i)
  (display (string-append "[" (second i) "]")))

; opcode vector
(define ops #(MULT ADD SET DISP))
(define opl #(4 4 2 2))

(define (get-modes m ic)#t)

(define (get-ins m ic)
  (let ((l '(0 0 0 0)))
    (do ((i 0 (1+ i))) ((>= i (vector-ref opl (vector-ref m ic))))
      (display l)(display " ")(display (vector-ref m (+ ic i)))
      (list-set! l i (list (vector-ref m (+ ic i))))
      (display l))
    l))

(define (exec m ic)
  (let ((opcode (vector-ref m ic)))
    (display opcode)
    (newline)
    (exec m (+ ic ((vector-ref ops opcode) m (get-ins m ic) ic)))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (let ((mem (list->vector i)))
      (display mem)
      (exec mem 0))))
