% Author: Eduardo Peixoto
% E-mail: eduardopeixoto@ieee.org
function enc_params = getEncoderParams()

enc_params = struct('sequence','',...
                    'testMode',[1 1],...
                    'verbose',0,...
                    'workspaceFolder','',...
                    'dataFolder','',...
                    'pointCloudFile','',...
                    'bitstreamFile','',...
                    'outputPlyFile','',...
                    'matlabFile','',...
                    'nBits',0,...
                    'nSymbolsDecoded',0,...
                    'nVoxelsDecoded',0,...
                    'BACParams',getBACParams());
                   