(= (runcpu $stmt)
   (unify $stmt (: (CPU $f $args) (CPU $res)) (: (CPU $f $args) (CPU (cons-atom $f $args))) $stmt))

!(bind! &eles ((: a A) (: b B) (: c C) (: d D) (: e E) (: f F) (: g G) (: h H) (: i I) (: j J) (: k K) (: l L) (: m M) (: n N) (: o O) (: p P) (: q Q) (: r R) (: s S) (: t T) (: u U) (: v V) (: w W) (: x X) (: y Y) (: z Z)))

!(assertEqual (let $mcset ((: a A) (: b B) (: c C) (: d D) (: e E) (: f F) (: g G) (: h H) (: i I) (: j J) (: k K) (: l L) (: m M) (: n N) (: o O) (: p P) (: q Q) (: r R) (: s S) (: t T) (: u U) (: v V) (: w W) (: x X) (: y Y) (: z Z)) (let $mcset (map-atom $mcset $s (runcpu $s)) $mcset)) &eles)

!(assertEqual (let $mcset ((: a A) (: b B) (: c C) (: d D) (: e E) (: f F) (: g G) (: h H) (: i I) (: j J) (: k K) (: l L) (: m M) (: n N) (: o O) (: p P) (: q Q) (: r R) (: s S) (: t T) (: u U) (: v V) (: w W) (: x X) (: y Y) (: z Z)) (let $mcseto (map-atom $mcset $s (runcpu $s)) $mcseto)) &eles)



(= (time-me) (let $mcset &eles (let $mcseto (map-atom $mcset $s (runcpu $s)) $mcseto))) 

!(assertEqual (time-me) &eles)

