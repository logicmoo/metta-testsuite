!(import! &self chainer)


!(bind! &f1 (init-kb))

!(add-to-kb &f1 (() ⊢ ((: (f1) A))))
!(add-to-kb &f1 (((: $b B)) ⊢ ((: $a A) (: (f2 $a $b) C))))

!(assertEqual (bc &f1 (S Z) (() ⊢ ((: $a A)))) (() ⊢ ((: (f1) A))))

!(bind! &f2 (init-kb))

!(add-to-kb &f2 (((: $a A)) ⊢ ((: (f1 $a) B))))
!(add-to-kb &f2 (((: $a A) (: $c C)) ⊢ ((: (f2 $a $c) D))))

!("Next may loop") !(repl!)

!(bc &f2 (S Z) (((: $a A)) ⊢ $type))

!(assertEqual (bc &f2 (S Z) (((: $a A)) ⊢ $type)) (((: $a A)) ⊢ ((: (f1 $a) B))))

!("112") !(repl!)

!(bind! &f3 (init-kb))

!(add-to-kb &f3 (((: $a A)) ⊢ ((: (f2 $a) B))))
!(add-to-kb &f3 (((: $z Z)) ⊢ ((: (f2 $a) B))))
!(add-to-kb &f3 (((: $a A) (: $b B)) ⊢ ((: (f3 $a $b) C))))
!(add-to-kb &f3 (((: $a A) (: $x X)) ⊢ ((: (ff $a $x) Y))))
!(add-to-kb &f3 (((: $c C)) ⊢ ((: (f4 $c) D))))

!(assertEqual (bc &f3 (S (S Z)) (((: $a A)) ⊢ ((: $d D))))
   (((: $a A)) ⊢ ((: (f4 (f3 $a (f2 $a))) D) (: (f3 $a (f2 $a)) C) (: (f2 $a) B))))

!("113") !(repl!)

!(bind! &b (init-kb))

!(add-to-kb &b (((: $a A)) ⊢ ((: (ab $a) B))))
!(add-to-kb &b (((: $b B)) ⊢ ((: (bc $b) C))))
!(add-to-kb &b (((: $c C)) ⊢ ((: (cd $c) D))))
!(add-to-kb &b (((: $d D)) ⊢ ((: (de $d) E))))
!(add-to-kb &b (((: $e E)) ⊢ ((: (ef $e) F))))
!(add-to-kb &b (((: $f F)) ⊢ ((: (fg $f) G))))
!(add-to-kb &b (((: $g G)) ⊢ ((: (gh $g) H))))

!(time (bcset &b (fromNumber 3) (((: $a A)) ⊢ ((: $f E)))))


