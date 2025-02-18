; test_get_type_bug_238.metta
;
; This test verifies the behavior of the built-in `get-type` function.
; Bug #238: `get-type` fails when applied to a constructed term of a user-defined type.
; Expected behavior: `get-type` should return the expected type.
; Observed behavior: Instead of returning `(Attribute)`, an error occurs.
; Bug report: https://github.com/trueagi-io/metta-wam/issues/238


(: Shape Type)
(: Box Shape)
(: Attribute Type)
(: MkShapeAttribute (-> Shape Attribute))

; Basic type checks – these should all pass.
!(assertEqualToResult (get-type Shape) (Type))
!(assertEqualToResult (get-type Box) (Shape))
!(assertEqualToResult (get-type Attribute) (Type))
!(assertEqualToResult (get-type MkShapeAttribute) ((-> Shape Attribute)))

; This is the failing case from bug #238.
; Expected: (Attribute)
; Current output: Error
!(assertEqualToResult (get-type (MkShapeAttribute Box)) (Attribute))


