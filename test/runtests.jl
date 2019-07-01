using StanSample, Test

TestDir = @__DIR__
tmpdir = joinpath(TestDir, "tmp")
if isdir(tmpdir)
  rm(tmpdir, recursive=true)
  mkdir(tmpdir)
end

basic_run_tests = [
  "test_basic_runs/test_bernoulli_dict.jl",
  "test_basic_runs/test_bernoulli_nt.jl",
]

sample_settings_tests = [
  "test_sample_settings/test_bernoulli.jl"
]

@testset "Bernoulli basic runs" begin
  for test in basic_run_tests
    println("\nTesting: $test.\n")
    include(joinpath(TestDir, test))
    @test sdf[:theta, :mean][1] ≈ 0.34 atol=0.1
  end
  println()
end

@testset "Bernoulli Sample() settings" begin
  for test in sample_settings_tests
    println("\nTesting: $test.\n")
    include(joinpath(TestDir, test))
    @test stanmodel.method.adapt.delta ≈ 0.85 atol=0.01
  end
  println()
end
