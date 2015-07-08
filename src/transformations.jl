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
import Base: show, *, size, +
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


@doc """
Compute the rotation Matrix from Euler angles from the convention ZYZ

Inputs:
------
ϕ: first angle of euler(Number)
θ: second angle of euler(Number)
ψ: third angle of euler(Number)

Output:
------

R: Rotation matrix(3x3 Array{Float64, 2})
""" ->
function euler2rot(ϕ::Number, θ::Number, ψ::Number)

    return R = rotz(ϕ) * roty(θ) * rotz(ψ)
end


@doc """
Compute the euler angles from a Rotation matrix(ZYZ convention)

Input:
-----

R: Rotation matrix(Array{Float64, 2})

Outputs:
------

ϕ: first angle of euler(Number)
θ: second angle of euler(Number)
ψ: third angle of euler(Number)

""" ->
function rot2euler(R::Array{Float64, 2})

    if abs(R[1,3]) < eps(Float64) && abs(R[2,3]) < eps(Float64)
        # singularity
        ϕ = 0.0
        sp = 0.0
        cp = 1.0
        θ = atan2(cp * R[1, 3] + sp * R[2, 3], R[3, 3])
        ψ = atan2(-sp * R[1, 1] + cp * R[2, 1], -sp * R[1, 2] + cp * R[2, 2])
    else
        # non-singular
        ϕ = atan2(R[2, 3], R[1, 3])
        sp = sin(ϕ)
        cp = cos(ϕ)
        θ = atan2(cp * R[1, 3] + sp * R[2, 3], R[3, 3])
        ψ = atan2(-sp * R[1, 1] + cp * R[2, 1], -sp * R[1, 2] + cp * R[2, 2])
    end

    return ϕ, θ, ψ
end



#-------------------------------------------------------------------------
# Points Types
#-------------------------------------------------------------------------
@doc """
Point2D type container for a cartesian 2D-Point 

example:
-------

`p = Point2D(1,1) # x=1, y=1`

""" ->
immutable Point2D{T<:Real} <: Number
    x :: T
    y :: T
end
#-------------------------------------------------------------------------
# maths Point2d
#-------------------------------------------------------------------------
# promote Point2d
Point2D(x::Real, y::Real) = Point2D(promote(x, y)...)

Point2D() = Point2D(0, 0) # canonical point2d
# sum of Point2d
+(p1::Point2D, p2::Point2D) = Point2D(p1.x + p2.x, p1.y + p2.y) 
# mul Array--Point2d


function *{T}(A::Array{T,2}, p::Point2D) 

   p2 = A * [p.x,p.y,1]
   
   return Point2D(p2[1], p2[2])
   
end


@doc """

Point type container for a 3-D cartesian Point representation

example:
-------

`p = Point(1, 1, 1) # x=1, y=1, z=1`

""" ->
immutable Point{T<:Real} <: Number
    x::T
    y::T
    z::T
end


#*************************************************************************
# Pose type 
#*************************************************************************
# TODO(elsuizo): look what is the better type to hierarchy


@doc """
A frame or Pose is a point with associated orientation

"""->
type Pose2D <: Number 
    p::Point2D
    θ::Real
    ξ::Array{Float64, 2}
    
    function Pose2D(x::Real, y::Real, θ::Real)
        p = Point2D(x, y) 
        ξ = [cos(θ) -sin(θ) p.x;sin(θ) cos(θ) p.y;0.0 0.0 1.0]
        new(p, θ, ξ)
    end
    function Pose2D(p::Point2D, θ::Real)
        ξ = [cos(θ) -sin(θ) p.x;sin(θ) cos(θ) p.y;0.0 0.0 1.0]
        new(p, θ, ξ)
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
    p3.p = p1.p + p1.ξ * p2.p 
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
