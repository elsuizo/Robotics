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
# NOTE(elsuizo:2019-09-04): lo que quiero hacer es que el punto tengo asociado un frame

mutable struct Point2D{T<:Real}
   x::T
   y::T
   frame::Symbol
end

Point2D() = Point2D(0, 0, :A) # canonical Point2D

function +(p1::Point2D, p2::Point2D)
   if p1.frame == p2.frame
      Point2D(p1.x + p2.x, p1.y + p2.y, p1.frame)
   else
      error("The frames of two points must be equals")
   end
end

function -(p1::Point2D, p2::Point2D)
   if p1.frame == p2.frame
      Point2D(p1.x - p2.x, p1.y - p2.y, p1.frame)
   else
      error("The frames of two points must be equals")
   end
end
