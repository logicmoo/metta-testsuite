#!/bin/bash

# Create the Java program file
cat > NQueensSolver.java <<'EOF'
public class NQueensSolver {

    // Check if placing a queen at (row, col) is safe
    private static boolean isSafe(int[] board, int row, int col) {
        for (int i = 0; i < col; i++) {
            if (board[i] == row || Math.abs(board[i] - row) == Math.abs(i - col)) {
                return false;
            }
        }
        return true;
    }

    // Recursive backtracking solution for the N-Queens problem
    private static void solveNQueens(int[] board, int col, int n, int[] count) {
        if (col == n) {
            count[0]++;
            return;
        }
        for (int row = 0; row < n; row++) {
            if (isSafe(board, row, col)) {
                board[col] = row;
                solveNQueens(board, col + 1, n, count);
            }
        }
    }

    // Solve N-Queens for a given board size
    public static int nQueens(int n) {
        int[] board = new int[n]; // Array to store queen positions
        int[] count = new int[1]; // Count of solutions (use array to pass by reference)
        solveNQueens(board, 0, n, count);
        return count[0];
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java NQueensSolver <board size>");
            return;
        }

        int n;
        try {
            n = Integer.parseInt(args[0]);
        } catch (NumberFormatException e) {
            System.out.println("Invalid input. Please provide an integer for the board size.");
            return;
        }

        if (n < 1) {
            System.out.println("Board size must be a positive integer.");
            return;
        }

        long startTime = System.nanoTime();
        int solutions = nQueens(n);
        long endTime = System.nanoTime();

        double timeTaken = (endTime - startTime) / 1e9; // Convert to seconds
        System.out.printf("N=%d: %d solutions found in %.6f seconds\n", n, solutions, timeTaken);
    }
}
EOF

# Compile the Java program
echo "Compiling NQueensSolver.java..."
javac NQueensSolver.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed. Exiting."
    exit 1
fi

# Benchmark the program for board sizes 4 through 15
echo "Benchmarking N-Queens (Java implementation)"
for n in {4..15}; do
    echo "N=$n:"
    /usr/bin/time -f "Elapsed Time: %E" java NQueensSolver $n
    echo
done

# Clean up
echo "Cleaning up..."
rm -f NQueensSolver.java NQueensSolver.class

