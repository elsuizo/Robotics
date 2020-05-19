# enable precompilation
__precompile__(true)

module Robotics

import Base: show, *, size, +

#=------------------------------------------------------------------------------
                           Includes
------------------------------------------------------------------------------=#
include("transformations.jl")
include("robots_types.jl")
include("utility.jl")
include("graphics.jl")
include("types.jl")
#=------------------------------------------------------------------------------
                              Exports
------------------------------------------------------------------------------=#
export   #types
         Point2D,
         #methods
         ξ,
         rot2,
         trot2,
         rotx,
         roty,
         rotz,
         show,
         euler2rot,
         rot2euler,
         angle_vector2rot,
         rot2trans,
         trotx,
         skew,
         skewa,
         vex,
         # graphics
         plot_frame,
         # utility
         generate_random_pose
end
#
# Robotics.jl ends here
