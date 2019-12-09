(use-modules (srfi srfi-1))  ;split-at,map,fold,etc
(use-modules (srfi srfi-11)) ;let-values

(define w (read))
(define h (read))
(display (string-append "w: " (number->string w) "\n"))
(display (string-append "h: " (number->string h) "\n"))

(define (count-n n p acc)
  (if (eq? p n)
      (+ acc 1)
      acc))

(define (image-chunk imgdata w h)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (display head)
    (let ((n0 (fold (lambda (p a) (count-n 0 p a)) 0 head)))
      (let ((n1 (fold (lambda (p a) (count-n 1 p a)) 0 head)))
        (let ((n2 (fold (lambda (p a) (count-n 2 p a)) 0 head)))
          (display n0)(newline)(display n1)(newline)(display n2))))
    (if (null? tail)
        #t
        (image-chunk tail w h))))

(define (char->number a)
  (string->number (string a)))

(let ((idata (map char->number (string->list (number->string (read ))))))
  (image-chunk idata w h))
