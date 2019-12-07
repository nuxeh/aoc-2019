(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

; +
(define (MULT m i)
  (display "MULT")(newline)
  (vector-set! m (third i) (* (fourth i) (fifth i))))

; *
(define (ADD m i)
  (display "ADD")(newline)
  (vector-set! m (third i) (+ (fourth i) (fifth i))))

; set
(define (SET m i)
  (let ((input (read)))
    (display (string-append "SET <" (number->string input) "> "))(newline)
    (vector-set! m (fourth i) input)))

; output
(define (DISP m i)
  (display (string-append "[" (number->string (fourth i)) "]"))(newline))

; output
(define (NULL m i)
  (display "NULL called"))

; opcode vector          1   2    3   4
(define ops (vector NULL ADD MULT SET DISP))
(define opn #(0 4 4 2 2))

(define (get-modes intcode)
  (let ((C (floor (/ intcode 10000))))
    (set! intcode (- intcode (* C 10000)))
    (let ((B (floor (/ intcode 1000))))
      (set! intcode (- intcode (* B 1000)))
      (let ((A (floor (/ intcode 100))))
        (set! intcode (- intcode (* A 100)))
        (list intcode C B A)))))

(define (get-ins m ic)
  (define op-modes (get-modes (vector-ref m ic)))
  (define op (first op-modes))
  (define opl (if (eq? op 99)
                  1
                  (vector-ref opn op)))
  (define l (list op opl 0 0 0 0))
  (do ((i 1 (1+ i))) ((>= i opl))
    (display op-modes)
    (if (eq? 1 (list-ref op-modes i))
        (list-set! l (+ i 2) (vector-ref m (+ ic i)))                 ;immediate
        (list-set! l (+ i 2) (vector-ref m (vector-ref m (+ ic i))))) ;position
    (if (eq? i 3)
        (list-set! l 2 (vector-ref m (+ ic i))))                      ;output
;    (display l)(display " ")(display (vector-ref m (+ ic i)))(newline))
  )(display l)l)

(define (exec m ic)
  (display m)(newline)
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
      (exec mem 0)
      (newline)(display (vector-ref mem 0))(display mem))))
