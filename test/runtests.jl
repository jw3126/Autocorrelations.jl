using Autocorrelations
using Autocorrelations: Sokal, fake_history
using Test

@testset "Autocorrelations.jl" begin
    for _ in 1:10
        history = fake_history(length=1e5, autocortime=10)
        @test effsize(history) ≈ 1e4 rtol=1e-1
        @test autocortime(history) ≈ 10 rtol=1e-1
    end
end
