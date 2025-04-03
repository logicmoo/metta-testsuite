# MeTTa Puzzle & Task Test Files

This repository contains a suite of MeTTa test cases along with expected output files, timeouts, and Prolog equivalents. The goal is to benchmark and validate logic inference across different implementations: Hyperon-Experimental, MeTTaLog Interpreter, and MeTTaLog Compiler.

| File Link | Hyperon-Experimental Time | MeTTaLog Interpreter Time | MeTTaLog Compiler Time | Description of Program/Test |
|-----------|----------------------------|-----------------------------|--------------------------|------------------------------|
| [puzzle.metta](./puzzle.metta) |  |  |  | Anatoly Belikov's puzzle.metta |
| [puzzle_less_function_guessing.metta](./puzzle_less_function_guessing.metta) |  |  |  | Anatoly Belikov's puzzle.metta with it easier to guess what is not a function; lists start with numbers |
| [task1_whole.metta](./task1_whole.metta) | 180 secs |  33 secs | 0.02 secs | Planner that must stack 3 blocks in `&self` |
| [task1_whole_if.metta](./task1_whole_if.metta) |  |  |  | Planner that must stack 3 blocks in `&self` (using conditional `if` rather than `case`) |
| [task1_whole_kb.metta](./task1_whole_kb.metta) |  |  |  | Planner that must stack 3 blocks in `&kb` |
| [task1_whole_atoms_kb.metta](./task1_whole_atoms_kb.metta) |  |  |  | Planner that must stack 3 blocks in `&kb` (using `intersect-atom` instead of `intersect`) |
| [task1_whole_atoms_kb0.metta](./task1_whole_atoms_kb0.metta) | 37 secs | 2 secs | 0.001 secs | Planner that must stack 1 block in `&kb` (using `intersect-atom` instead of `intersect`) |
| [task1_whole_kb_noprint.metta](./task1_whole_kb_noprint.metta) |  |  |  | Planner that must stack 3 blocks in `&kb` (no debug output) |
| [fish_riddle_1_no_states.metta](./fish_riddle_1_no_states.metta) |  |  |  | Simplified vers	ion of the Zebra Puzzle with only 2 houses |

