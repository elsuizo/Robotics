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
using Robotics
@testset "transformations" begin
   R1 = rotx(deg2rad(30))
   R2 = rotx(deg2rad(30 + 360))
   @test R1 == R2
end


