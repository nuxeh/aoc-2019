(use-modules (ice-9 rdelim))

(do ((c (read-line) (read-line)))
    ((eof-object? c) 'done)
    (display c)(newline))
