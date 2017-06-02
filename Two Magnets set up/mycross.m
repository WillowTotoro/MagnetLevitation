function [res] = mycross(v1, v2)
    v1 = [v1;0];
    v2 = [v2;0];
    res = cross(v1, v2);
    res = res(3);
  
end