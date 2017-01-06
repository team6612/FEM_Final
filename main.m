clc;
clear;

% plot setting
mesh = false;
dvector = true;

global X Y D T rN cN nN;

rN = 64;              % Number of mesh row
cN = 128;              % Number of mesh coloum
nN = (rN+1)*(cN+1);   % Number of node

a = 0.5;
X = [0 0 2   2];
Y = [1 0 0.5 1];

[X Y] = MESH(X, Y, rN, cN);

nu = 0.3;
E = 3e7;
D = E/(1-nu^2)*[ 1 nu 0;
                 nu 1 0;
                 0  0 (1-nu)/2 ];

T = [ 0; -20 ];

%dNod = [ 1 2 3 4 ];
%dVal = [ 0 0 0 0 ];

mKe = Ke(1, 1);
%F = Fe()

K = Kg(rN, cN);
F = Fg();

d = Inf(nN*2,1);
dNod = [ 1 2 ];
dVal = [ 0 0 ];
d(dNod) = dVal(:);

for i=1:rN
  dNod = [ i*(cN+1)*2+1 i*(cN+1)*2+2 ];
  dVal = [ 0 0 ];
  d(dNod) = dVal(:);
end
d;

res = SOLVE(K, F, d);
[s gp] = STRESS(res);
s = reshape(s,cN*rN*4,3);
gp = reshape(gp,cN*rN*4,2);

r=reshape(res,(cN+1)*2,(rN+1))';
x=r(:,[1:2:end]);
y=r(:,[2:2:end]);
X=reshape(X,(cN+1),(rN+1))';
Y=reshape(Y,(cN+1),(rN+1))';
Z=sqrt(x.^2+y.^2);

row = 2*rN;
col = 2*cN;
figure;

subplot(2,2,1);
[cs, hc] = contourf(X,Y,Z,20);
set(hc,'EdgeColor','none');
colormap(jet);
hold on;
if mesh
  plot(X,Y,'r');
  plot(X',Y','r');
end
if dvector
  quiver(X,Y,x,y);
end
hold off;

subplot(2,2,2);
data = [gp(:,1) gp(:,2) s(:,1)];
data = sortrows(data);
[cs, hc] = contourf(reshape(data(:,1),row,col),reshape(data(:,2),row,col),reshape(data(:,3),row,col),20);
set(hc,'EdgeColor','none');
colormap(jet);
hold on;
if mesh
  plot(X,Y,'r');
  plot(X',Y','r');
end
if dvector
  quiver(X,Y,x,y);
end
hold off;

subplot(2,2,3);
data = [gp(:,1) gp(:,2) s(:,2)];
data = sortrows(data);
[cs, hc] = contourf(reshape(data(:,1),row,col),reshape(data(:,2),row,col),reshape(data(:,3),row,col),20);
set(hc,'EdgeColor','none');
colormap(jet);
hold on;
if mesh
  plot(X,Y,'r');
  plot(X',Y','r');
end
if dvector
  quiver(X,Y,x,y);
end
hold off;

subplot(2,2,4);
data = [gp(:,1) gp(:,2) s(:,3)];
data = sortrows(data);
[cs, hc] = contourf(reshape(data(:,1),row,col),reshape(data(:,2),row,col),reshape(data(:,3),row,col),20);
set(hc,'EdgeColor','none');
colormap(jet);
hold on;
if mesh
  plot(X,Y,'r');
  plot(X',Y','r');
end
if dvector
  quiver(X,Y,x,y);
end
hold off;
