
;;;;;;;;;;;;;;;;;
;; Combinators ;;
;;;;;;;;;;;;;;;;;

;; Combinators are disabled as they have been moved to the backward
;; chainer

;; ;; Name: Bluebird
;; ;; Description: Sequential composition
;; ;; Type: (b -> c) -> (a -> b) -> a -> c
;; ;; Definition: bluebird f g x = f (g x)
;; ;; Symbol: .
;; ;; Diagram:
;; ;; -a-b-c->
;; !(add-atom &kb (: .
;;                   (-> (: $f (-> (: $y $b) $c))
;;                       (: $g (-> (: $x $a) $b))
;;                       (-> (: $x $a) $c))))

;; ;; Name: Phoenix
;; ;; Description: Split then join
;; ;; Type: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
;; ;; Definition: phoenix f g h x = f (g x) (h x)
;; ;; Symbol: Φ (LaTeX: \Phi, Math Emacs: \upPhi)
;; ;; Diagram:
;; ;;    b
;; ;;   / \
;; ;; -a   d->
;; ;;   \ /
;; ;;    c
;; !(add-atom &kb (: Φ
;;                   (-> (: $f (-> (: $y $b) (: $z $c) $d))
;;                       (: $g (-> (: $x $a) $b))
;;                       (: $h (-> (: $x $a) $c))
;;                       (-> (: $x $a) $d))))

;;;;;;;;;;;;;;;;;;;;;
;; Reduction rules ;;
;;;;;;;;;;;;;;;;;;;;;

;; Bluebird β-reduction
(= ((. $g $f) $x)   
   ($g ($f $x)))

!(mvar! (assertEqual 
  ((. (. $h $g) $f) $x)
  ($h ($g ($f $x)))))

!(mvar!
(assertEqual 
  ((. $h (. $g $f)) $x)
  ($h ($g ($f $x)))))



!(add-history!  !((. $h (. $g $f)) $x))
!(add-history!  !((. (. $h $g) $f) $x))