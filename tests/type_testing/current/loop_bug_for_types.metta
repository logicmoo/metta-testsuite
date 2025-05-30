
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Types as propositions can be used in MeTTa but with nuances
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Entities
(: Entity Type)
(: Socrates Entity)
(: Plato Entity)

; Predicates (functions) from `Entity` to `Type`
(: Human (-> Entity Type))
(: Mortal (-> Entity Type))

; `(Mortal Plato)` is an expression of `Type` type
; It represents the proposition "Plato is mortal"
; but doesn't mean this proposition is inhabited/proven
!(assertEqual
  (get-type (Mortal Plato))
  Type)

; A function type as an implication
; `HumansAreMortal` represents the implication:
; "For all x, if Human(x) then Mortal(x)"
(: HumansAreMortal (-> (Human $t) (Mortal $t)))
; NOTE: MeTTa doesn't differentiate between type constructors and
;       other symbols (including functional) of the same type.
;       Thus, ATM, we cannot prove any proposition with universal
;       quantification (e.g., that all humans are mortal) by
;       providing a total function as an instance of a
;       corresponding type.

; These might be considered as assertions that Plato and
; Socrates are Humans:
(: SocratesIsHuman (Human Socrates))
(: PlatoIsHuman (Human Plato))

; `(HumansAreMortal SocratesIsHuman)` might be considered
; as a proof that that `(Mortal Socrates)`.
!(assertEqual
  (get-type (HumansAreMortal SocratesIsHuman))
  (Mortal Socrates))
; Bad typing
!(assertEqualToResult
  (get-type (HumansAreMortal (Human Socrates)))
  ())

; We can write this code, but it will make not too much
; difference for the assertion that "all humans are mortal"
(: SocratesIsMortal (Mortal Socrates))
(= (HumansAreMortal SocratesIsHuman) SocratesIsMortal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Equality can be typed. If some equality is well-typed,
; it means that it can be true.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(nop (remove-atom &self (: equ (-> Atom Atom Atom))))
(nop (remove-atom &corlib (: equ (-> Atom Atom Atom))))
(: equ (-> $t $t Type))

!("sameTypes" (get-type SocratesIsMortal) (get-type (HumansAreMortal SocratesIsHuman)))
!(assertEqual
  (get-type (equ SocratesIsMortal (HumansAreMortal SocratesIsHuman)))
  Type)
; This equality is well-typed, because both its arguments are of `Type`.
; It doesn't mean they are both inhabited (true propositions), and
; it doesn't mean that the equality itself is true (an inhabited type).

!("sameTypes" (get-type (Mortal Socrates)) (get-type (Mortal Plato)))
!(assertEqual
  (get-type (equ (Mortal Socrates) (Mortal Plato)))
  Type)


!("!sameTypes" (get-type SocratesIsMortal) (get-type (HumansAreMortal PlatoIsHuman)))
; Wrong proof
!(assertEqualToResult
  (get-type (equ SocratesIsMortal (HumansAreMortal PlatoIsHuman)))
  ())


!("!sameTypes" (get-type SocratesIsHuman) (get-type PlatoIsHuman))
; Wrong equalities
!(assertEqualToResult
  (get-type (equ SocratesIsHuman PlatoIsHuman))
  ())

!("!sameTypes" (get-type SocratesIsHuman) (get-type SocratesIsMortal))
!(assertEqualToResult
  (get-type (equ SocratesIsHuman SocratesIsMortal))
  ())


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A standard type-theoretic way of saying that some equality is true
; is to present an instance of the corresponding equality type.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (: Refl (-> (: $x $T) (equ $x $x))).
; As per https://github.com/trueagi-io/hyperon-experimental/issues/177 ,
; there is no way to match both argument and its type in type definition.
; Such syntax `(: (Refl $x) (-> Type (equ $x $x)))` also doesn't work now.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Another (MeTTa) way is to have explicit reduction of types to True
; (equalities over equalities), although a more practical way would
; be just to use a dedicated comparison operator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TALKABOUT

(: T Type)
(= (equ $x $x) T)

; These equalities will be true
!(assertEqual
  (equ SocratesIsMortal (HumansAreMortal SocratesIsHuman))
  T)
!(assertEqual
  (equ (+ 1 1) (- 3 1))
  T)

; One can also define an equality for directly inhabited types
(= (equ $type T)
   (match &self (: $x $type) T))
!(assertEqual
  (equ (Mortal Socrates) T)
  T)

; It will not immediately work for implications
!(assertEqualToResult
  (equ (Mortal Plato) T)
  ())

; But we can add 'reasoning'
(= (equ $type T)
   (match &self (: $impl (-> $cause $type))
	  (equ $cause T)))
!(assertEqual
  (equ (Mortal Plato) T)
  T)
(: Sam Entity)
!(assertEqualToResult
  (equ (Human Sam) T)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Types by themselves will not be reduced
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!(assertEqualToResult
   (Mortal Plato)
  ((Mortal Plato)))
; Refl rule itself equals to True
!(assertEqual
  (equ (equ $x $x) T)
  T)

; We can also add direct equalities
; (equ (Human Socrates) T)
(= (Human Plato) T)
(= (Mortal Socrates) T)
(= (Mortal $x) (Human $x))
; Then, the type of type itself will be reduced
!(assertEqual
  (Mortal Plato)
  T)

; We can even try backward chaining
(: ift (-> Type $t $t))
(= (ift T $then) $then)
!(assertEqualToResult
  (ift (Mortal $x) $x)
  (Socrates Plato))

