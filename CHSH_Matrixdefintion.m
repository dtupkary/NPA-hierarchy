addpath 'C:\Program Files\Mosek\9.0\toolbox\R2015aom';
addpath(genpath('C:\Program Files\MATLAB\packages\YALMIP-master'));


S=GenerateOps([2,2],[2,2],[2,2],2);
G=GenerateOps([2,2],[2,2],[2,2],4);
ls=length(S)
lg=length(G)

v=sdpvar(1,lg);
M=sdpvar(ls,ls);
F=[M>=0];
for i=1:ls
    for j=1:ls
        element=ProductOps(Adjoint(S(i)),S(j));
        if strcmp(element.status,'O')
            F=[F,M(i,j)==0];
        elseif strcmp(element.status,'I')
            F=[F,M(i,j)==1];
        else
            F=[F,M(i,j)==v(IndexOf(element,G))];
        end
    end
end

% M=[]
% for i=1:ls
%     for j=1:ls
%         element=ProductOps(Adjoint(S(i)),S(j))
%         
%         if strcmp(element.status,'O')
%             M=[M,0];
%         elseif strcmp(element.status,'I')
%             M=[M,1];
%         else
%             M=[M,v(IndexOf(element,G))];
%         end
%     end
% end
% M = transpose(reshape(M,ls,ls));



%All constraints have been inputed. Now we must construct the CHSH
%quantity.

for i = 2:ls
    for j = 1:i-1
        M(i,j) = M(j,i);
    end
end

%-2 + 4 A11 + 4 B11 - 4 A11 B11 - 4 A21 B11 - 4 A11 B21 + 4 A21 B21 + 
% 4 C11 - 4 A11 C11 - 4 A21 C11 - 4 B11 C11 + 8 A21 B11 C11 - 
% 4 B21 C11 + 8 A11 B21 C11 - 4 A11 C21 + 4 A21 C21 - 4 B11 C21 + 
% 8 A11 B11 C21 + 4 B21 C21 - 8 A21 B21 C21
% This is the expression for the mermin violation.



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


C11.status = '1';
C11.as = '';
C11.ao = '';
C11.bs = '';
C11.bo = '';
C11.co = '1' ;
C11.cs = '1' ;


C21.status = '1';
C21.as = '';
C21.ao = '';
C21.bs = '';
C21.bo = '';
C21.co = '1' ;
C21.cs = '2' ;
%Now move on to the 2 multiples that appear.

A11B11=ProductOps(A11,B11);
A11B21=ProductOps(A11,B21);
A21B11=ProductOps(A21,B11);
A21B21=ProductOps(A21,B21);
A11C11=ProductOps(A11,C11);
A21C11=ProductOps(A21,C11);
B11C11=ProductOps(B11,C11);
B21C11=ProductOps(B21,C11);
A11C21=ProductOps(A11,C21);
A21C21=ProductOps(A21,C21);
B11C21=ProductOps(B11,C21);
B21C21=ProductOps(B21,C21);

%Now three multiple

A21B11C11=ProductOps(A21B11,C11);
A11B21C11=ProductOps(A11B21,C11);
A11B11C21=ProductOps(A11B11,C21);
A21B21C21=ProductOps(A21B21,C21);

%Start using the index now.
a11 = v(IndexOf(A11,G));
a21 = v(IndexOf(A21,G));
b11 = v(IndexOf(B11,G));
b21 = v(IndexOf(B21,G));
c11 = v(IndexOf(C11,G));
c21 = v(IndexOf(C21,G));

a11b11 = v(IndexOf(A11B11,G));
a11b21 = v(IndexOf(A11B21,G));
a21b11 = v(IndexOf(A21B11,G));
a21b21 = v(IndexOf(A21B21,G));

a11c11 = v(IndexOf(A11C11,G));
a11c21 = v(IndexOf(A11C21,G));
a21c11 = v(IndexOf(A21C11,G));
a21c21 = v(IndexOf(A21C21,G));

b11c11 = v(IndexOf(B11C11,G));
b11c21 = v(IndexOf(B11C21,G));
b21c11 = v(IndexOf(B21C11,G));
b21c21 = v(IndexOf(B21C21,G));

a21b11c11=v(IndexOf(A21B11C11,G));
a11b21c11=v(IndexOf(A11B21C11,G));
a11b11c21=v(IndexOf(A11B11C21,G));
a21b21c21=v(IndexOf(A21B21C21,G));


obj=-2+4*a11+4*b11-4*a11b11-4*a21b11-4*a11b21+4*a21b21+4*c11-4*a11c11-4*a21c11-4*b11c11+8*a21b11c11-4*b21c11+8*a11b21c11-4*a11c21+4*a21c21-4*b11c21+8*a11b11c21+4*b21c21-8*a21b21c21;


optimize(F,obj);
value(M);
double(-obj)

value(-2+4*a11+4*b11-4*a11b11-4*a21b11-4*a11b21+4*a21b21+4*c11-4*a11*c11-4*a21*c11-4*b11c11+8*a21b11c11-4*b21c11+8*a11b21c11-4*a11*c21+4*a21*c21-4*b11c21+8*a11b11c21+4*b21c21-8*a21b21c21)

value(a11)
value(c11)
value(a11c11)
        