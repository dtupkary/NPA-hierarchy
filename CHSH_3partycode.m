addpath 'C:\Program Files\Mosek\9.0\toolbox\R2015aom';
addpath(genpath('C:\Program Files\MATLAB\packages\YALMIP-master'));

S=GenerateOps([2,2],[2,2],[1],2);
G=GenerateOps([2,2],[2,2],[1],4);
ls=length(S);
lg=length(G);

v=sdpvar(1,lg);
M=[];
for i=1:ls
    for j=1:ls
        element=ProductOps(Adjoint(S(i)),S(j));
        if strcmp(element.status,'O')
            M=[M,0];
        elseif strcmp(element.status,'I')
            M=[M,1];
        else
            M=[M,v(IndexOf(element,G))];
        end
    end
end
% F=[];
% M=[];
% M=sdpvar(ls,ls)
% for i=1:ls
%     for j=1:ls
%         element=ProductOps(Adjoint(S(i)),S(j));
%         
%         if strcmp(element.status,'O')
%             F=[F,M(i,j)==0];
%         elseif strcmp(element.status,'I')
%             F=[F,M(i,j)==1];
%         else
%             F=[F,M==v(IndexOf(element,G))];
%         end
%     end
% end
% 
% 
% 
M = transpose(reshape(M,ls,ls));

%All constraints have been inputed. Now we must construct the CHSH
%quantity.

for i = 2:ls
    for j = 1:i-1
        M(i,j) = M(j,i);
    end
end

A11.status = '1';
A11.as = '1';
A11.ao = '1';
A11.bs = '';
A11.bo = '';
A11.co = '' ;
A11.cs = '' ;

A21.status = '1';
A21.as = '2';
A21.ao = '1';
A21.bs = '';
A21.bo = '';
A21.co = '' ;
A21.cs = '' ;

B11.status = '1';
B11.as = '';
B11.ao = '';
B11.bs = '1';
B11.bo = '1';
B11.co = '' ;
B11.cs = '' ;


B21.status = '1';
B21.as = '';
B21.ao = '';
B21.bs = '2';
B21.bo = '1';
B21.co = '' ;
B21.cs = '' ;

A11B11=ProductOps(A11,B11);
A11B21=ProductOps(A11,B21);
A21B11=ProductOps(A21,B11);
A21B21=ProductOps(A21,B21);

% A11B11.status = '1';
% A11B11.as = '1';
% A11B11.ao = '1';
% A11B11.bs = '1';
% A11B11.bo = '1';
% A11B11.co = '' ;
% A11B11.cs = '' ;
% 
% A11B21.status = '1';
% A11B21.as = '1';
% A11B21.ao = '1';
% A11B21.bs = '2';
% A11B21.bo = '1';
% A11B21.co = '' ;
% A11B21.cs = '' ;
% 
% A21B11.status = '1';
% A21B11.as = '2';
% A21B11.ao = '1';
% A21B11.bs = '1';
% A21B11.bo = '1';
% A21B11.co = '' ;
% A21B11.cs = '' ;
% 
% A21B21.status = '1';
% A21B21.as = '2';
% A21B21.ao = '1';
% A21B21.bs = '2';
% A21B21.bo = '1';
% A21B21.co = '' ;
% A21B21.cs = '' ;

a11 = v(IndexOf(A11,G));
a21 = v(IndexOf(A21,G));
b11 = v(IndexOf(B11,G));
b21 = v(IndexOf(B21,G));
a11b11 = v(IndexOf(A11B11,G));
a11b21 = v(IndexOf(A11B21,G));
a21b11 = v(IndexOf(A21B11,G));
a21b21 = v(IndexOf(A21B21,G));

a1b1 = 4*a11b11 - 2*a11 - 2*b11 + 1;
a1b2 = 4*a11b21 - 2*a11 - 2*b21 + 1;
a2b1 = 4*a21b11 - 2*a21 - 2*b11 + 1;
a2b2 = 4*a21b21 - 2*a21 - 2*b21 + 1;

obj = a1b1+a1b2+a2b1-a2b2;

F = [M>=0];

optimize(F,obj);
value(M);
double(-obj)


        