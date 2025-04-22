(= (to-list $expr)
   (if (== $expr ()) Nil
     (Cons (car-atom $expr)
         (to-list (cdr-atom $expr)))))

(= (to-list' $expr $tail)
   (if (== $expr ()) $tail
     (Cons (car-atom $expr)
         (to-list' (cdr-atom $expr) $tail))))

(= (flatten-list Nil) Nil)
(= (flatten-list (Cons $head $tail))
  (case (get-metatype $head)
    ((Expression (to-list' $head (flatten-list $tail)))
     ($_ (Cons $head (flatten-list $tail))))))

; (: from-list (-> (List $a) Expression))
(= (from-list Nil) ())
(= (from-list (Cons $head $tail))
   (let $tail-list (from-list $tail)
    (cons-atom $head $tail-list)))

(= (flatten-expr $expr) (from-list (flatten-list (to-list $expr))))

(= (apply_subst_tok $tok)
  (let $res (unify &subst ($tok $sub) $sub $tok) $res))

(= (apply_subst $stmt)
    (flatten-expr (map-atom $stmt $tok (apply_subst_tok $tok))))

> !(apply_subst ("|-" "P"))
