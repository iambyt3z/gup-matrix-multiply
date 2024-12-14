# CUDA Matrix Multiplication (SGEMM)

This project implements single-precision General Matrix Multiplication (SGEMM) using NVIDIA CUDA. The program benchmarks GPU-based matrix multiplication and validates its results against a CPU implementation.

---

## Features
- Matrix multiplication (`C = A x B`) with configurable dimensions.
- Host-to-device and device-to-host memory transfers for CUDA execution.
- Kernel launch and performance measurement for GPU execution.
- Verification of GPU results against the CPU for correctness.
- Command-line interface for flexible matrix size configuration.

---

## Getting Started

### Prerequisites
- NVIDIA GPU with CUDA support.
- NVIDIA CUDA Toolkit installed.
- Compiler compatible with CUDA (`nvcc`).
- `Make` utility for building the project.

### Installation
1. Clone the repository:

```bash
git clone <repository-url>
```

2. Compile the project:

```bash
make
```

### Usage

Running the Program
Execute the compiled program with one of the following options:

1. Default size (all matrices `1000 x 1000`):

```bash
./sgemm-tiled
```

2. Custom square matrix size (e.g., `512 x 512`):

```bash
./sgemm-tiled 512
```

3. Custom matrix size (e.g., `m x n = (m x k) * (k x n)`):

```bash
./sgemm-tiled <m> <k> <n>
```
`<m>` : Rows in matrix A.
`<k>` : Columns in matrix A and rows in matrix B.
`<n>` : Columns in matrix B.
