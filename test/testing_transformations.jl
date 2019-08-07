#= -------------------------------------------------------------------------
# @file testing_transformations.jl
#
# @date 08/07/19 08:34:43
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
#
# @detail
#
#  Licence:
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License

---------------------------------------------------------------------------=#
# testing
using Robotics, LinearAlgebra
# NOTE(elsuizo:2019-08-07): no usar == cuando se comparan Floats
@testset "transformations" begin
   @testset "rotx" begin
      R1 = rotx(deg2rad(30))
      R2 = rotx(deg2rad(30 + 360))
      @test R1 ≈ R2
      @test det(R1) ≈ det(R2) ≈ 1.0
   end
   @testset "roty" begin
      R3 = roty(deg2rad(30))
      R4 = roty(deg2rad(30 + 360))
      @test R3 ≈ R4
      @test det(R3) ≈ det(R4) ≈ 1.0
   end
   @testset "rotz" begin
      R5 = rotz(deg2rad(30))
      R6 = rotz(deg2rad(30 + 360))
      @test R5 ≈ R6
      @test det(R5) ≈ det(R6) ≈ 1.0
   end
end


