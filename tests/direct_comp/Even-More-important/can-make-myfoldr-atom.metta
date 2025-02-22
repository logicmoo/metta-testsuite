;;Fold right to maintain the order of the list
(= (myfoldr-atom $list $init $f)
   (if-decons-expr $list $head $tail
      ($f (myfoldr-atom $tail $init $f) $head)
      $init))

!(assertEqual (myfoldr-atom (1 2 3) 0 +) 6)
