# transformations.jl --- 
# 
# Filename: transformations.jl
# Description: Main transformation operations for robotics stuff
# Author: Martin Noblía
# Maintainer: 
# Created: mié may  6 21:53:51 2015 (-0300)
# Version: 0.0.1
# Package-Requires: ()
# Last-Updated: 
#           By: 
#     Update #: 0

# Commentary: 
# 
# 
# 
# 
# 
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
# 
# 

# Code:
#*************************************************************************
# Imports
#*************************************************************************

import Base.show, Base.*, Base.size
using Docile

#*************************************************************************
# Rotations
#*************************************************************************

@doc """
Compute the rotation around the `x` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

Rₓ : Rotation matrix of angle Input

example:
-------

`R = rotx(deg2rad(30)) # rotation around x 30 degrees`
 """ ->
function rotx(∠::Number)
    
    Rₓ = [1   0       0;
          0 cos(∠) -sin(∠);
          0 sin(∠) cos(∠)]

    return Rₓ
end


@doc """
Compute the rotation around the `y` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

R_y: Rotation matrix of angle Input

example:
-------
`R = roty(deg2rad(30)) # rotation around y 30 degrees`

 """ ->
function roty(∠::Number)

    R_y = [cos(∠)  0  sin(∠);
           0       1     0;
           -sin(∠) 0  cos(∠)]

    return R_y
end


@doc """
Compute the rotation around the `z` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

R_z: Rotation matrix of angle Input

example:
-------

`R = rotz(deg2rad(30)) # rotation around z 30 degrees`
""" ->
function rotz(∠::Number)

    R_z = [cos(∠)  -sin(∠) 0;
           sin(∠)   cos(∠) 0;
            0          0   1]

    return R_z
end


#-------------------------------------------------------------------------
# Point Type
#-------------------------------------------------------------------------
@doc """
Point2D type container for a cartesian 2D-Point 

example:
-------

`p = Point2D(1,1) # x=1, y=1`

""" ->
immutable Point2D{T} <: Number
    x :: T
    y :: T
end
Point2D() = Point2D(0, 0) # canonical point2d
#*************************************************************************
# Pose type 
#*************************************************************************
# TODO(elsuizo): look what is the better type to hierarchy
type Pose2D <: Number 
    x::Real
    y::Real
    θ::Real
    ξ::Array{Float64,2}
    
    function Pose2D(x::Real, y::Real, θ::Real)
    
        ξ = [cos(θ) -sin(θ) x;sin(θ) cos(θ) y;0.0 0.0 1.0]
        new(x , y, θ, ξ)
    end
    function Pose2D(p::Point2D, θ::Real)
        ξ = [cos(θ) -sin(θ) p.x;sin(θ) cos(θ) p.y;0.0 0.0 1.0]
        new(p.x, p.y, θ, ξ)
    end
end

Pose2D() = Pose2D(0.0, 0.0, 0.0) # canonical Pose
#-------------------------------------------------------------------------
# Show 
#-------------------------------------------------------------------------
function show(io::IO, p::Pose2D)
    print(io,p.ξ)
end

#-------------------------------------------------------------------------
# Size of 
#-------------------------------------------------------------------------
size(p::Pose2D) = size(p.ξ)

#-------------------------------------------------------------------------
# Maths with Pose
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
# Inverse
#-------------------------------------------------------------------------
function ⊖(p::Pose2D) 
    
    p.ξ[1:2,1:2] = p.ξ[1:2,1:2]'
    
    p.ξ[1:2,3] = -p.ξ[1:2,1:2] * p.ξ[1:2,3]
    
    return p
end
#-------------------------------------------------------------------------
# Product
#-------------------------------------------------------------------------
function ⊕(p1::Pose2D, p2::Pose2D)
    p3 = Pose2D() # Pose type
    p3.ξ = p1.ξ * p2.ξ 
    p3.x = p3.ξ[1,3]
    p3.y = p3.ξ[2,3]
    p3.θ = p1.θ + p2.θ
    return p3
end

function *(p1::Pose2D, p::Point2D)
   p2 = p1.ξ * [p.x, p.y, 1]
   return Point2D(p2[1], p2[2])
end

function *{T}(p1::Pose2D, p::Array{T, 2})
    p2 = p1.ξ * p
    return Point2D(p2[1], p2[2])
end

# transformations.jl ends here
#**************************************************************************
