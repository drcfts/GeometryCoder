% Author: Eduardo Peixoto
% E-mail: eduardopeixoto@ieee.org
function enc = getEncoder()

enc = struct('params',getEncoderParams(),...
             'stat',[],...
             'pointCloud',[],...
             'geometryCube',[],...
             'dimensionSliced','',...
             'pcLimit',0,...
             'numberOfOccupiedVoxels',0,...
             'rate',0,...
             'rate_bpov',0,...
             'bitstream',[]);
                    