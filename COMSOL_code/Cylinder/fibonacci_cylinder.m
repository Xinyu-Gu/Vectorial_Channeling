function cg = fibonacci_cylinder ( r, n, rise )
  phi = ( 3 - sqrt ( 5.0 ) ) * pi;
  cg = zeros ( n, 3 );
  
  i = 1:1:n;
  theta = i * phi;
  z = i * rise;

  cg(1:n,1) = r * sin ( theta );
  cg(1:n,2) = r * cos ( theta );
  cg(1:n,3) = z;

  return
end