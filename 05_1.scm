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
(define ops (vector MULT ADD SET DISP))
(define opl #(4 4 2 2))

(define (get-modes m ic)#t)

(define (get-ins m ic)
  (define count (vector-ref opl (vector-ref m ic)))
  (define l (list 0 0 0 0))
  (list-set! l 0 count)
  (do ((i 1 (1+ i))) ((>= i count))
    (list-set! l i (vector-ref m (+ ic i)))
    (display l)(display " ")(display (vector-ref m (+ ic i)))(newline))
  l)

(define (exec m ic)
  (let ((opcode (vector-ref m ic)))
    (define i (get-ins m ic))
    ((vector-ref ops opcode) m i)
    (display opcode)
    (newline)
    (exec m (+ ic (list-ref i 0)))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (let ((mem (list->vector i)))
      (display mem)(newline)
      (display ops)(newline)
      (exec mem 0))))
