# PkgLock.jl

This package allows you to avoid race conditions when instantiating and precompiling Julia projects. This is particularly useful when using a common depot which multiple Julia processes might have access to (e.g. when working on a HPC cluster with a shared file system).

In particular, this partially works around the following issues:
- https://github.com/JuliaLang/julia/issues/17320
- https://github.com/JuliaLang/julia/pull/30174
- https://github.com/JuliaLang/Pkg.jl/issues/1219

## Usage

This currently provides one function `instantiate_precompile` which will attempt to run `Pkg.instantiate()` and `Pkg.precompile()`. If the latter fails, it will attempt to rerun `Pkg.build()` and `Pkg.precompile()`.

A typical usage might be:
```
julia --project -e 'using PkgLock; PkgLock.instantiate_precompile()'
# run program which uses the project
```
