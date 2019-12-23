(define pack-size (read))

(define (make-pack n c pack)
  (if (< c n)
      (make-pack n (1+ c) (append pack (list c)))
      pack))

(display (make-pack pack-size 0 '()))
