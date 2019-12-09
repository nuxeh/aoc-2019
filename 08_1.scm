(use-modules (srfi srfi-1))

(define w (read))
(define h (read))
(display (string-append "w: " (number->string w) "\n"))
(display (string-append "h: " (number->string h) "\n"))

(define (image-chunk imgdata w h)
  (let-values ((head tail (split-at imgdata w)))


(let ((idata (read )))
  (display idata))
