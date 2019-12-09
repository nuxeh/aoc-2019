(use-modules (srfi srfi-1))  ;split-at,map,fold,etc
(use-modules (srfi srfi-11)) ;let-values

(define w (read))
(define h (read))
(display (string-append "w: " (number->string w) "\n"))
(display (string-append "h: " (number->string h) "\n"))

(define (image-chunk imgdata w h)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (display head)
    (if (null? tail)
        #t
        (image-chunk tail w h))))


(let ((idata (string->list (number->string (read )))))
  (image-chunk idata w h))
