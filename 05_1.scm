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
(define opn #(0 4 4 2 2))

(define (get-modes intcode)
  (let ((C (floor (/ intcode 10000))))
    (set! intcode (- intcode (* C 10000)))
    (let ((B (floor (/ intcode 1000))))
      (set! intcode (- intcode (* B 1000)))
      (let ((A (floor (/ intcode 100))))
        (set! intcode (- intcode (* A 100)))
  (display intcode)(newline)
  (display C)(newline)
  (display B)(newline)
  (display A)(newline)
  (display intcode)(newline)
  (list intcode C B A))))) 

(define (get-ins m ic)
  (define op-modes (get-modes (vector-ref m ic)))
  (define op (first op-modes))
  (define opl (vector-ref opn op))
  (define l (list op opl 0 0 0))
  (do ((i 1 (1+ i))) ((>= i opl))
    (if (< 1 (list-ref op-modes i))
        (list-set! l (+ i 1) (vector-ref m (vector-ref m (+ ic i)))) ;position
        (list-set! l (+ i 1) (vector-ref m (+ ic i))))               ;immediate
    (display l)(display " ")(display (vector-ref m (+ ic i)))(newline))
  l)

(define (exec m ic)
  (let ((ins (get-ins m ic)))
    (let ((op (first ins)))
      (if (eq? op 99)
          #t
          (begin ((vector-ref ops op) m ins)
            (exec m (+ ic (second ins))))))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (let ((mem (list->vector i)))
      (display mem)(newline)
      (display ops)(newline)
      (exec mem 0))))
