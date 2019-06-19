# PkgLock.jl

This package allows you to avoid race conditions when instantiating and precompiling Julia projects. This is particularly useful when using a common depot which multiple Julia processes might have access to (e.g. when working on a HPC cluster with a shared file system).

In particular, this partially works around the following issues:
- https://github.com/JuliaLang/julia/issues/17320
- https://github.com/JuliaLang/julia/pull/30174
- https://github.com/JuliaLang/Pkg.jl/issues/1219

## Usage

This currently provides one function `instantiate_precompile` which will attempt to run `Pkg.instantiate()` and `Pkg.precompile()`. If the latter fails, it will attempt to rerun `Pkg.build()` and `Pkg.precompile()`.

Note that you probably don't want to add PkgLock.jl as a dependency to your project. Instead, a typical usage would be to install PkgLock.jl into a shared environment, and then use it in your initialization scripts.

For example, you could add it to a shared environment named `pkglock`:
```julia
julia -e 'using Pkg; Pkg.activate("pkglock"; shared=true); Pkg.add("PkgLock")'
```
(this only needs to be done once)

Then in your job submission script, you might have
```
julia --project -e 'push!(LOAD_PATH, "@pkglock"); using PkgLock; PkgLock.instantiate_precompile()'
# run program which uses the project
```
