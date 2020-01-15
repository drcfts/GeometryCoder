% Author: Eduardo Peixoto
% E-mail: eduardopeixoto@ieee.org
function cabac = encodeImageBAC_withMask_Inter(A,mask,pA,cabac)

%This function uses the contexts in:
% cabac.BACContexts_2DT_Masked

w4D   = cabac.BACParams.windowSizeFor4DContexts;
padpA = padarray(pA, [w4D w4D]);

A    = double(A);
padA = padarray(A,[3 3]);

maxValueContext = cabac.BACParams.maxValueContext;

currBACContext = getBACContext(false,maxValueContext/2,maxValueContext);

numberOfContexts = cabac.BACParams.numberOfContextsMasked;

[idx_i, idx_j] = find(mask');
for k = 1:1:length(idx_i)
    y = idx_j(k);
    x = idx_i(k);        %It only encodes it IF the mask says so.
    
    currSymbol = A(y,x);
    contextNumber = get2DContext(padA, [y x], numberOfContexts);
    contextNumber4D = getContextLeft(padpA, [y x], w4D);
    
    %Gets the current count for this context.
    currCount = cabac.BACContexts_2DT_Masked(contextNumber4D, contextNumber + 1,:);
    
    %Gets the current BAC context for this context
    p1s = currCount(2) / (sum(currCount));
    
    if (p1s > 0.5)
        currBACContext.MPS = true;
        currBACContext.countMPS = floor(p1s * maxValueContext);
    else
        currBACContext.MPS = false;
        currBACContext.countMPS = floor((1 - p1s) * maxValueContext);
    end
    
    %Encodes the current symbol using the current context probability.
    cabac.BACEngine = encodeOneSymbolBAC(cabac.BACEngine,currBACContext,currSymbol);
    
    %Updates the context.
    if (currSymbol == false)
        cabac.BACContexts_2DT_Masked(contextNumber4D, contextNumber + 1,1) = cabac.BACContexts_2DT_Masked(contextNumber4D, contextNumber + 1,1) + 1;
    else
        cabac.BACContexts_2DT_Masked(contextNumber4D, contextNumber + 1,2) = cabac.BACContexts_2DT_Masked(contextNumber4D, contextNumber + 1,2) + 1;
    end
    
end
