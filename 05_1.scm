(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

; +
(define (MULT m i)
  (display "1")
  (vector-set! m (fourth i) (+ (vector-ref m (second i)) (vector-ref m (third i)))))
(define (MULT' m i)
  (vector-set! m (fourth i) (+ (vector-ref m (second i)) (vector-ref m (third i)))))

; *
(define (ADD m i)
  (display "2")
  (vector-set! m (fourth i) (* (vector-ref m (second i)) (vector-ref m (third i)))))

; set
(define (SET m i)#t)

; output
(define (DISP m i)
  (display (string-append "["  "]")))

; opcode vector
(define ops #(MULT ADD SET DISP))
(define ops' #(one' two' three' four'))
(define opl #(4 4 2 2))

(define (get-modes m ic)#t)

(define (get-ins m ic)
  (let ((l (list)))
    (do ((i 1 (1+ i))) ((> i 4))
      (display i)
      (append l (vector-ref m (+ ic i))))l))

(define (exec m ic)
  (let ((opcode (vector-ref m ic)))
    (exec m (+ ic ((vector-ref ops opcode) m (get-ins m ic) ic)))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (let ((mem (list->vector i)))
      (display mem)
      (exec mem 0))))
