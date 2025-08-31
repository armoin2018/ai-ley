Title: Fortran — AI Agent Implementation Guide

Use cases
- High-performance numerical computing; legacy scientific codebases; HPC kernels.

Modern Fortran
- Prefer Fortran 2008/2018 features: modules, derived types, allocatables, coarrays.
- Tooling: fpm (Fortran Package Manager) for project structure and tests.

Interop
- C interoperability (ISO_C_BINDING) for integration with C/C++/Python (via C-ABI).
- Prefer generating thin C wrappers for Python bindings (cffi) where needed.

Performance
- Use array operations and DO CONCURRENT; avoid unnecessary temporaries.
- Profile with gprof, perf, or compiler reports; vectorization flags enabled.

Builds
- Use CMake or fpm; target gfortran/ifx/nvfortran as required.

Testing
- fpm test frameworks; compare against analytical results; tolerance-based assertions.

AI Assistant Guidelines
- Only suggest Fortran when performance-critical numerics or legacy integration is explicit.
- Generate fpm project skeletons; include CI with compiler matrix.
- Provide C-ABI stubs if interop is requested; document calling conventions.

