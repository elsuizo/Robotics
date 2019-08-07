#= -------------------------------------------------------------------------
# @file runtests.jl
#
# @date 08/07/19 08:25:17
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
# Testing
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
using Test

# NOTE(elsuizo:2019-08-07): desde aqui vamos a llamar un archivo de test por cada
# archivo que haya en el src
@testset "Robotics" begin
   include("testing_transformations.jl")
end


