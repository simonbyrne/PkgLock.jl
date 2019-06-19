module PkgLock

export instantiate_precompile

using Pkg, Pidfile

function instantiate_precompile()
    lock = mkpidlock(joinpath(DEPOT_PATH[1], "lock"))
    try
        Pkg.instantiate()
        Pkg.API.precompile()
    catch
        Pkg.build()
        Pkg.API.precompile()
    finally
        close(lock)
    end
end
   

end # module
