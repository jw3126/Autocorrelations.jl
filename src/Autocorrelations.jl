module Autocorrelations
import Statistics
using FFTW: fft, ifft
using Random: AbstractRNG, GLOBAL_RNG

export effsize, autocortime

function obtain_mean(samples, μ)
    if μ === nothing
        Statistics.mean(samples)
    else
        μ
    end
end

function autocov_full(history::AbstractVector; mean=nothing)
    μ = obtain_mean(history, mean)
    if !iszero(μ)
        history = history .- μ
    end
    x̂ = fft(history)
    autocov_complex = ifft(x̂ .* conj.(x̂) ./ length(x̂))
    autocov_real = real.(autocov_complex)
    @assert autocov_real ≈ autocov_complex
    autocov_real
end

function autocor_full(history; mean=nothing)
    μ = obtain_mean(history, mean)
    σ² = Statistics.var(history, mean=μ)
    autocov_full(history, mean=μ) ./ σ²
end

"""
    Sokal(c)

Estimate `τ = 1 + Σ_{1<=i<=M } ρᵢ` where `M` is minimal with `c*τ < M`.
See [this blog post](https://dfm.io/posts/autocorr/).
"""
struct Sokal{T}
    c::T
end

function autocortime_from_autocor(ρ, alg::Sokal)
    # Sokal:
    # estimate τ = 1 + Σ_{1<=i<=M } ρᵢ
    # where M is minimal with c*τ < M
    c = alg.c
    T = eltype(ρ)
    τ = -one(T)
    for (i,ρᵢ) in enumerate(ρ)
        τ = 2*ρᵢ + τ
        if c*τ < i
            return τ
        end
    end
    return τ
end

"""
    τ = autocortime(history, alg=Sokal(5))

Estimate the autocorrelation time from a vector of history.
"""
function autocortime(history, alg=Sokal(5))
    ρ = autocor_full(history)
    autocortime_from_autocor(ρ, alg)
end

"""
    effsize(history, alg=Sokal(5))

Estimate the effective sample size.
"""
function effsize(history, alg=Sokal(5))
    τ = autocortime(history, alg)
    length(history) / τ
end

function fake_history(rng::AbstractRNG=GLOBAL_RNG;length, autocortime)
    ret = Vector{Float64}(undef, Int(length))
    window = randn(rng,Int(autocortime))
    val = sum(window)
    for i in eachindex(ret)
        ret[i] = val
        remove = popfirst!(window)
        add = randn(rng)
        push!(window, add)
        val = val + add - remove
    end
    return ret
end


end # module
