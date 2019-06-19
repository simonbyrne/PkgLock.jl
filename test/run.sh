#!/usr/bin/env bash

rm -rf .tempdepot
export JULIA_DEPOT_PATH=".tempdepot"

julia -e 'using Pkg; Pkg.develop(PackageSpec(path=dirname(pwd())))'
julia --project=. -e 'using PkgLock; PkgLock.instantiate_precompile(); using Distributions' &
julia --project=. -e 'using PkgLock; PkgLock.instantiate_precompile(); using Distributions' &
wait

rm -rf .tempdepot
