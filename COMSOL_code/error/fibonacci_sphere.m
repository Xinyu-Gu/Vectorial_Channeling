function cg = fibonacci_sphere ( r, n )
  phi = ( 3 - sqrt ( 5.0 ) ) * pi;
  cg = zeros ( n, 3 );
  
  i = 0:1:(n-1);
  theta = i * phi;
  z = r*(1 - (i /(n-1)) * 2);
  cross = sqrt(r*r-z.*z);

  cg(1:n,1) = cross .* sin ( theta );
  cg(1:n,2) = cross .* cos ( theta );
  cg(1:n,3) = z;

  return
end