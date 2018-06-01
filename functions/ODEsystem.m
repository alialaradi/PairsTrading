function dy = ODEsystem(t,y,a,b,phi,psi)    
    
    dy = zeros(3,1);
    
    dy(1) = (phi+psi)-1/a*y(1)^2-1/(4*b)*y(3)^2;
    dy(2) = (phi+psi)-1/b*y(2)^2-1/(4*a)*y(3)^2;
    dy(3) = 2*psi-1/a*y(1)*y(3)-1/b*y(2)*y(3);

end