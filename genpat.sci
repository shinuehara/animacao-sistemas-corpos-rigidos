function patches = genpat(vertices, faces)
    // Generate patches data from vertices and faces
    patches.x = vertices(:,1)(faces');
    patches.y = vertices(:,2)(faces');
    patches.z = vertices(:,3)(faces');
endfunction
