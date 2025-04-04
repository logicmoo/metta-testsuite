
!(import! &corelib corelib)
!(remove-atom &corelib (: * (-> Number Number Number)))

!(import! &self py_ops)
!(remove-atom &self (: * (-> Number Number Number)))
(: * (-> String Number $t))
!(assertEqual (* "a" 4) (py-atom "'aaaa'"))


