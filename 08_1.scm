(use-modules (srfi srfi-1))  ;split-at,map,fold,etc
(use-modules (srfi srfi-11)) ;let-values

(define w (read))
(define h (read))
(display (string-append "w: " (number->string w) "\n"))
(display (string-append "h: " (number->string h) "\n"))

(define (count-zeroes l acc)
  (if (eq? l 0)
      (+ acc 1)
      acc))

(define (image-chunk imgdata w h)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (display head)
    (let ((nz (fold count-zeroes 0 head)))
      (display nz))
    (if (null? tail)
        #t
        (image-chunk tail w h))))

(define (char->number a)
  (string->number (string a)))

(let ((idata (map char->number (string->list (number->string (read ))))))
  (image-chunk idata w h))
