#= -------------------------------------------------------------------------
# @file pose_plots.jl
#
# @date 10/06/16 22:10:53
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
# A small example generate a n number of Pose2D and plot it
# @detail
#
  Licence:
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
using Robotics
# generate 50 random Pose2D in [-3,3]
v = generate_random_pose(50, -3:3)
# plot all Pose2D in one figure
plot_frame(v)
