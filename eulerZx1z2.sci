function R = eulerZx1z2(a1, a2, a3)
    // Convert XYZ Euler angles to rotation matrix
    
    //angulos aeronauticos 
    
    R1 = [
        cos(a1), -sin(a1), 0;
        sin(a1), cos(a1), 0;
        0, 0, 1];
    
    R2 = [
        1, 0, 0;
        0, cos(a2), -sin(a2);
        0, sin(a2), cos(a2)];
    
    R3 = [
        cos(a3), -sin(a3), 0;
        sin(a3), cos(a3), 0;
        0, 0, 1];
    
    R = R1*R2*R3;

endfunction
