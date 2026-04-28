from org.hipparchus.geometry.euclidean.threed import Vector3D

# Return unit vector along a Vector3D.
def unit_vector(v: Vector3D):
    return Vector3D(v.getX()/v.getNorm(),
                    v.getY()/v.getNorm(),
                    v.getZ()/v.getNorm())

# Return the angles between a vector and the x,y,z axes.
def axes_angles(v: Vector3D):
    return v.angle(v, Vector3D(1.0,0.0,0.0)), \
           v.angle(v, Vector3D(0.0,1.0,0.0)), \
           v.angle(v, Vector3D(0.0,0.0,1.0))