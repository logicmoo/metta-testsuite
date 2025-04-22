(= (append_1 $expr $atom)
  (case (get-metatype $expr)
    ((Expression
      (if (== $expr ()) ($atom)
        (let* (($head (car-atom $expr))
              ($tail (cdr-atom $expr))
              ($tail-new (append_1 $tail $atom)))
            (cons-atom $head $tail-new))))
     ($_ (append_1 ($expr) $atom)))))
  
(= (append-atom $expr $app)
  (case (get-metatype $app)
    ((Expression 
      (if-decons-expr $app $head $tail (append-atom (append_1 $expr $head) $tail) $expr))
      ; (foldl-atom $app $expr $acc $v (append_1 $acc $v)))
     ($_ 
      (append_1 $expr $app)))))

(= (apply_subst1 $stmt)
  (if-decons-expr $stmt $tok $tail 
    (let $sub (unify &subst ($tok $s) $s $tok) (append-atom $sub (apply_subst1 $tail))) ()))


!(apply_subst1 ("|-" "P"))
[("|-" "(" "t" "+" "0" ")" "=" "t")]
