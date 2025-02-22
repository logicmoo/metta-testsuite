from hyperon.ext import register_atoms
from hyperon import *

def plus_unwrap_true(atom1, atom2):
    print("\nplus_unwrap_true:", type(atom1), type(atom2), flush=True)
    from hyperon import ValueAtom
    sum_value = atom1 + atom2  # Unwrap=True means direct numerical values are passed
    return sum_value

def plus_unwrap_false(atom1, atom2):
    print("\nplus_unwrap_false:", type(atom1), type(atom2), flush=True)
    from hyperon import ValueAtom
    sum_value = atom1.get_object().value + atom2.get_object().value  # Needs .get_object()
    return [ValueAtom(sum_value, 'Number')]

def ident_unwrap_false(atom1):
    print("\nident_unwrap_false type/value:", type(atom1), atom1, flush=True)
    return [atom1]  # No need to wrap since unwrap=False

def ident_unwrap_true(atom1):
    print("\nident_unwrap_true type/value:", type(atom1), atom1, flush=True)
    return [atom1]   # No need to rewrap since unwrap=True


from hyperon import OperationAtom

# Store OperationAtoms in a dictionary
my_atoms_dict = {

    "plus_unwrap_true": OperationAtom("plus_unwrap_true", plus_unwrap_true, 
        ['Number', 'Number', 'Number'], unwrap=True),

    "plus_unwrap_false": OperationAtom("plus_unwrap_false", plus_unwrap_false, 
        ['Number', 'Number', 'Number'], unwrap=False),

    "ident_unwrap_false": OperationAtom("ident_unwrap_false", ident_unwrap_false,
                                        ['Atom', 'Atom'], unwrap=False),

    "ident_unwrap_true": OperationAtom("ident_unwrap_true", ident_unwrap_true,
                                        ['Atom', 'Atom'], unwrap=True),

}

@register_atoms
def my_atoms():
    return my_atoms_dict

if __name__ == '__main__':
    # Initialize MeTTa
    metta = MeTTa()

    # Register atoms properly
    for name, atom in my_atoms_dict.items():
        metta.register_atom(name, atom)

    # Run test cases
    print(metta.run('! (plus_unwrap_true 1 (+ 10 100))'))   # Uses plus_unwrap_true_atom (unwrap=True)
    print(metta.run('! (plus_unwrap_false 2  (+ 20 200))'))  # Uses plus_unwrap_false_atom (unwrap=False)
    print(metta.run('! (ident_unwrap_false (+ 3 30))'))
    print(metta.run('! (ident_unwrap_false (quote (+ 4 40)))'))
    print("\n===============================================")
    print(metta.run('! (ident_unwrap_true  (+ 5 50))'))
    print(metta.run('! (ident_unwrap_true  (quote (+ 6 60)))'))

