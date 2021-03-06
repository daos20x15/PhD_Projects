function val=bellman_int(k,j,v0,r,price,type,k0,gender)
% This program gets the value function for a neoclassical growth model with
% no uncertainty and CRRA utility
[sigma,endow_all,~,a,na,beta,pp,~,~,~,amin,amax,~,~,~,~,n_st,~,alpha,~,~,~,~,gamma_all]=parameters(1);
%global v0 beta delta alpha kmat k0 s kgrid y P
 if type==1 
     endow = endow_all(:,1);
     gamma = gamma_all(:,1);
 else
     endow = endow_all(:,2);
     gamma = gamma_all(:,2);
 end

klo=max(sum(k>a),1); % identify the gridpoint that falls just below . .
 % . . the choice for k
 khi=klo+1;

%% Do the interpolation
%gg = v0(klo,:) + (k-a(klo))*(v0(khi,:) - v0(klo,:))/(a(khi) - a(klo));
%gg = interp1([kmat(klo),kmat(khi)],[v0(klo),v0(khi)],k,'line');
%gg = interp1(a,v0,k,'line'); % it was jusnt one value

%% Do what Raul said
%a_aux = linspace(amin,amax,na);
%coeff = zeros(size(v0,1),n_st);
%gg = zeros(size(v0,1),n_st);
for i =1:n_st
  coeff     = polyfit(a',v0(:,i),2);

  gg(1,i)    = polyval(coeff,k);
end

 %c = k0^alpha - k + (1-delta)*k0; % consumption
% c = k0*(1+r) + endow(j) - k; % consumption
if gender == 1
     c = (endow(j) + (1+r)*k0-k)/(1+price^(1-(1/sigma)));
     x = c*price^(1/-sigma);
else
     l = (endow(j)/(alpha*price))^(1/(alpha-1));
     x = l^alpha;
     c = price*x+(endow(j)*(1-l))+(1+r)*k0-k;
end
if c<=0 || x<=0 || k<amin
val = -9999999 - 999*abs(c);
else
%val = (1/(1-s))*(c^(1-s)) + beta*((gg(1,1)*P(j,1))+(gg(1,2)*P(j,2)));
val = u(c,x,gender) + beta*gamma(j,1)*((gg(1,1)*pp(j,1))+(gg(1,2)*pp(j,2))+(gg(1,3)*pp(j,3))+(gg(1,4)*pp(j,4)));
 end
 val = -val; 