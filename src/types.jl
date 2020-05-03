#= -------------------------------------------------------------------------
# @file types.jl
#
# @date 09/04/19 20:26:25
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
import Base.+
import Base.-
import Base.zero
import Base.convert
# NOTE(elsuizo:2019-09-04): lo que quiero hacer es que el punto tengo asociado un frame
# TODO(elsuizo:2020-05-03): no se si queda bien porque hay que estar poniendo todo el tiempo a que frame pertenece
# cada cosa, por ahora lo dejo para mas adelante

mutable struct Point2D{T<:Real}
   x::T
   y::T
end

zero(var::Point2D{T}) where T<:Real = Point2D(zero(T), zero(T))

convert(::Type{Point2D{T}}, p::Point2D{S}) where {T<:Real,S<:Real} = Point2D(convert(T, p.x), convert(T, p.y))

Point2D() = Point2D(0, 0)


"""
Create a pose Matrix
"""
ξ(θ::T, x::T, y::T) where T<:Real = @SMatrix [cos(θ) -sin(θ) x;sin(θ) cos(θ) y; 0.0 0.0 1.0]
#
ξ(θ::T, p::Point2D{T}) where T<:Real = @SMatrix [cos(θ) -sin(θ) x;sin(θ) cos(θ) y; 0.0 0.0 1.0]

