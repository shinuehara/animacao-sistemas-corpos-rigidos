function vertices = transver(vertices_0, r, R)
// Transform vertices by translation vector r and rotation matrix R

    vertices = repmat(r', size(vertices_0, 1), 1) + vertices_0*R';

endfunction
