#= -------------------------------------------------------------------------
# @file transformations.jl
#
# @date 2019-04-09
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
# Common Robotics transformations
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
# NOTE(elsuizo:2019-04-09): usamos esto por performance ya que sabemos de antemano el size de los arrays
#=------------------------------------------------------------------------------
imports
------------------------------------------------------------------------------=#
using StaticArrays
using LinearAlgebra

#=------------------------------------------------------------------------------
code
------------------------------------------------------------------------------=#
# TODO(elsuizo:2020-04-16): tendria que hacer la conversion a rad o deg en las funciones
# o sino con algun package como UnitfulAngle.jl

function rot2(θ::Real)
    @SMatrix [cos(θ) -sin(θ);
              sin(θ)   cos(θ)]
end

function trot2(θ::Real)
   R = @SMatrix zeros(3, 3)
   R[:, end] = [0.0, 0.0, 1.0]
   R[1:2, 1:2] = rot2(θ)
   return R
end

"""
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
"""
function rotx(θ::Real)
   Rₓ = @SMatrix [1.0   0.0       0.0;
                  0.0  cos(θ) -sin(θ);
                  0.0  sin(θ)   cos(θ)]

   return Rₓ
end


"""
Compute the rotation around the `y` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

R_y: Rotation matrix of angle input

example:
-------
`R = roty(deg2rad(30)) # rotation around y 30 degrees`

"""
function roty(θ::Real)

   R_y = @SMatrix [cos(θ)  0.0  sin(θ);
                    0.0    1.0     0.0;
                  -sin(θ)  0.0  cos(θ)]

   return R_y
end


"""
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
"""
function rotz(θ::Real, type_of_angle::Symbol=:deg)

   R_z = @SMatrix [cos(θ)  -sin(θ) 0.0;
                   sin(θ)   cos(θ) 0.0;
                    0.0       0.0  1.0]

   return R_z
end

"""
Rotatation about x axis
"""
function trotx(θ::Real)
   return rot2trans(rotx(θ))
end

"""
Rotatation about y axis
"""
function troty(θ::Real)
   return rot2trans(roty(θ))
end

"""
Rotatation about z axis
"""
function trotz(θ::Real)
   return rot2trans(rotz(θ))
end

"""
Convert a 3x3 Rotation matrix to a 4x4 homogeneous transformation
"""
function rot2trans(r::AbstractArray{Float64, 2})
   R = @SMatrix zeros(4,4)
   R[:, end] = [0.0, 0.0, 0.0, 1.0]
   R[1:3, 1:3] = r
   return R
end


"""
Compute the rotation Matrix from Euler angles from the convention ZYZ

Inputs:
------
ϕ: first angle of euler(Number)
θ: second angle of euler(Number)
ψ: third angle of euler(Number)

Output:
------

R: Rotation matrix(3x3 Array{Float64, 2})
"""
function euler2rot(ϕ::Real, θ::Real, ψ::Real)

    return R = rotz(ϕ) * roty(θ) * rotz(ψ)
end


"""
Compute the rotation Matrix from Euler angles from the convention ZYZ

Input:
------
vec: Vector with the euler angles([ϕ, θ, ψ])

Output:
------

R: Rotation matrix(3x3 Array{Float64, 2})

"""
function euler2rot(vec::Array{T,1}) where T<:Real
   l = length(vec)
   if l != 3
      error("The length of the vector must be 3")
   end
   return R = rotz(vec[1]) * roty(vec[2]) * rotz(vec[3])
end

"""
Compute the euler angles from a Rotation matrix(ZYZ convention)

Input:
-----

R: Rotation matrix(Array{Float64, 2})

Outputs:
------

ϕ: first angle of euler(radian Number)
θ: second angle of euler(radian Number)
ψ: third angle of euler(radian Number)

"""
function rot2euler(R::AbstractArray{T, 2}) where T<:Real

    if abs(R[1,3]) < eps(Float64) && abs(R[2,3]) < eps(Float64)
        # singularity
        ϕ = 0.0
        sp = 0.0
        cp = 1.0
        θ = atan(cp * R[1, 3] + sp * R[2, 3], R[3, 3])
        ψ = atan(-sp * R[1, 1] + cp * R[2, 1], -sp * R[1, 2] + cp * R[2, 2])
    else
        # non-singular
        ϕ = atan(R[2, 3], R[1, 3])
        sp = sin(ϕ)
        cp = cos(ϕ)
        θ = atan(cp * R[1, 3] + sp * R[2, 3], R[3, 3])
        ψ = atan(-sp * R[1, 1] + cp * R[2, 1], -sp * R[1, 2] + cp * R[2, 2])
    end

    return rad2deg(ϕ), rad2deg(θ), rad2deg(ψ)
end

"""
Compute the Rotation from Euler angles

Inputs:
------
ϕ: first angle of euler(Number)
θ: second angle of euler(Number)
ψ: third angle of euler(Number)

Output:
------

R: Rotation homogeneous matrix(4x4 Array{Float64, 2})
"""
function euler2trans(ϕ, θ, ψ)
   return rot2trans(euler2rot(ϕ, θ, ψ))
end

"""
Compute the Rotation matrix from an arbitrary axis and angle.

Inputs:
------

θ: Angle of rotation(any Real number)
v: axis of rotation(Array{T, 1} with T any Real number)

Output:
------

R: Rotation matrix(AbstractArray{T, 2})
"""
function angle_vector2rot(θ::T, v::AbstractArray{T, 1}) where T<:Real

   cth = cos(θ)
   sth = sin(θ)
   vth = (one(T) - cth)
   v_x = v[1]; v_y = v[2]; v_z = v[3]
   @SMatrix [
      v_x*v_x*vth+cth      v_y*v_x*vth-v_z*sth   v_z*v_x*vth+v_y*sth
      v_x*v_y*vth+v_z*sth   v_y*v_y*vth+cth      v_z*v_y*vth-v_x*sth
      v_x*v_z*vth-v_y*sth   v_y*v_z*vth+v_x*sth   v_z*v_z*vth+cth
   ]
end

function skew(number:: T) where T<:Real
   z = zero(number)
   @SMatrix [z -number; number z]
end

function skew(v::Vector{T}) where T<:Real
   # checking the imput
   l = length(v)
   l == 3 || throw(DimensionMismatch("the vector must be of length 3 or scalar"))
   # for type-stability
   z = zero(T)
   @SMatrix [  z   -v[3]  v[2];
             v[3]    z   -v[1];
            -v[2]   v[1]   z  ]
end

# FIXME(elsuizo): No puedo asi como esta convertirlo a StaticArray, porque me tira un error
"""
Compute the augmented skew-symmetric matrix from a vector `v`

Inputs:
------

v: Vector

Output:
------

R: AbstractArray{T}
"""
function skewa(v::Vector{T}) where T<:Real
   # checking the imput
   l = length(v)
   l == 3 || l == 6 || throw(DimensionMismatch("the vector must be of 3 or 6 elements"))
   # for type-stability
   z = zero(T)
   if l == 3
      [skew(v[3]) v[1:2]; z z z]
   elseif l == 6
      [skew(v[4:6]) v[1:3]; z z z z]
   end
end

function vex(m::AbstractArray{T}) where T<:Real
   z = zero(T)
   s = size(m)
   # check the size of the matrix
   s == (3, 3) || s == (2, 2) || throw(DimensionMismatch("The matrix must be 2x2 or 3x3"))

   # check if the matrix are skew
   all(diag(m) .== z) || throw(error("the input must be skew-symetric"))

   if s == (3, 3)
      result = 0.5 * [m[3,2] - m[2,3]; m[1,3] - m[3,1]; m[2,1] - m[1,2]]
      convert.(T, result)
   else
      result = 0.5 * (m[2,1] - m[1,2])
      convert.(T, result)
   end
end

# TODO(elsuizo:2020-04-16): terminar esta funcion que parece que llama a otras que faltan hacer
function vexa(m::AbstractArray{T}) where T<:Real
   # check the size of the matrix
   s == (4, 4) || s == (3, 3) || throw(DimensionMismatch("The matrix must be 2x2 or 3x3"))
end
