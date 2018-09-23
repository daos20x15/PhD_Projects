function val=bellman_int(k,j,v0,r,price,type,k0)
% This program gets the value function for a neoclassical growth model with
% no uncertainty and CRRA utility
[sigma,endow_all,~,a,na,beta,pp,~,~,~,~,~,~,~,~,~,n_st,ngk,alpha,nit,tol,epsilon,tol1,gamma,phy]=parameters(1);
%global v0 beta delta alpha kmat k0 s kgrid y P
endow = endow_all(:,1);

klo=max(sum(k>a),1); % identify the gridpoint that falls just below . .
 % . . the choice for k
 khi=klo+1;

% do the interpolation
gg = v0(klo,:) + (k-a(klo))*(v0(khi,:) - v0(klo,:))/(a(khi) - a(klo));
%gg = interp1([kmat(klo),kmat(khi)],[v0(klo),v0(khi)],k,'line');
%interp1(a,v,kp,'spline'
 %c = k0^alpha - k + (1-delta)*k0; % consumption
% c = k0*(1+r) + endow(j) - k; % consumption
 c = (endow(j) + (1+r)*k0-k)/(1+price^(1-(1/sigma)));
 x = c*price^(1/-sigma);
if c<=0 || x<=0
val = -9999999 - 999*abs(c);
else
%val = (1/(1-s))*(c^(1-s)) + beta*((gg(1,1)*P(j,1))+(gg(1,2)*P(j,2)));
val = u(c,x,type) + beta*gamma(j,1)*((gg(1,1)*pp(j,1))+(gg(1,2)*pp(j,2))+(gg(1,3)*pp(j,3))+(gg(1,4)*pp(j,4)));
 end
 val = -val; 