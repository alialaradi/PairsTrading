function dy = ODEsystem2(t,y,a,b,kappa,time,f2,g2,u)
   
    f2 = interp1(time,f2,t);
    g2 = interp1(time,g2,t);
    u  = interp1(time,u,t);
    
    dy = zeros(2,1);
      
    dy(1) = -(f2/a-kappa)*y(1)-(u/(2*b))*y(2)+kappa;
    dy(2) = -(g2/b-kappa)*y(2)-(u/(2*a))*y(1)-kappa;    

end