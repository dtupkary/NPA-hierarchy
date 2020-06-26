function [p]=IndexOf(Op,List)
%returns the index of given operator Op in the reference list LIST.

p=0;

for i=1:length(List)
    if isequal(List(i),Op)
        p=i;
        return;
    end
end

        
   