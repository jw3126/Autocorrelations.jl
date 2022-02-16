# Autocorrelations

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jw3126.github.io/Autocorrelations.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jw3126.github.io/Autocorrelations.jl/dev)
[![Build Status](https://github.com/jw3126/Autocorrelations.jl/workflows/CI/badge.svg)](https://github.com/jw3126/Autocorrelations.jl/actions)
[![Coverage](https://codecov.io/gh/jw3126/Autocorrelations.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jw3126/Autocorrelations.jl)

[Autocorrelations.jl](git@github.com:jw3126/Autocorrelations.jl.git) allows to calculate autocorrelation related quantities from time series.

# Usage

```julia
julia> using Autocorrelations

julia> history = Autocorrelations.fake_history(length=100000, autocortime=100)
100000-element Vector{Float64}:
 11.742731623791604
 10.92831975503304
  ⋮
 -6.34382319036773
 -8.3344985975821

julia> autocortime(history) # autocorrelation time
100.566257571999

julia> effsize(history) # effective sample size
994.3693084970016
```
