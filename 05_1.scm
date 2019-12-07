(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

; +
(define (MULT m i)
  (display "MULT"))
;  (vector-set! m (fourth i) (+ (vector-ref m (second i)) (vector-ref m (third i)))))

; *
(define (ADD m i)
  (display "ADD"))
;  (vector-set! m (fourth i) (* (vector-ref m (second i)) (vector-ref m (third i)))))

; set
(define (SET m i)
  (display "SET"))

; output
(define (DISP m i)
  (display (string-append "[" (second i) "]")))

; output
(define (NULL m i)
  (display "NULL called"))

; opcode vector
(define ops (vector NULL MULT ADD SET DISP))
(define opl #(0 4 4 2 2))

(define (get-modes intcode)
  #t)

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
    (if (eq? opcode 99)
        #t
        (let ((i (get-ins m ic)))
          ((vector-ref ops opcode) m i)
          (exec m (+ ic (list-ref i 0)))))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (let ((mem (list->vector i)))
      (display mem)(newline)
      (display ops)(newline)
      (exec mem 0))))
