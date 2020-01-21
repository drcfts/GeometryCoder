% Script script_testParameters

% This script tests different number of values for parameters for lossy
% compression, in order to infer the most adequate ones for optimization

% To achieve that, the codec is run over a group of 4 frames

nFrames = 4;

PSNR = zeros(nFrames, 1);
MSE = zeros(nFrames,1);
Rates = zeros(nFrames,1);

% for i = 1:nFrames
%     inputPly{i}   = ['C:\Users\drcft\OneDrive\Documents\UnB\Mestrado\Pesquisas\Sequences\longdress_vox10\longdress_vox10_13' ...
%         num2str(i-1,'%02d') '.ply'];
%     binaryFile{i} = ['..\test_nSlices\longdress_vox10_13' num2str(i-1,'%02d') '.bin'];
%     outputPly{i}  = ['..\test_nSlices\longdress_vox10_13' num2str(i-1,'%02d') '.ply'];
% end

parfor i = 1:nFrames
    inputPly   = ['C:\Users\drcft\OneDrive\Documents\UnB\Mestrado\Pesquisas\Sequences\longdress_vox10\longdress_vox10_13' ...
        num2str(i-1,'%02d') '.ply'];
    binaryFile = ['..\test_nSlices\longdress_vox10_13' num2str(i-1,'%02d') '.bin'];
    outputPly  = ['..\test_nSlices\longdress_vox10_13' num2str(i-1,'%02d') '.ply'];
    
    %Runs the Encoder
    enc = encodePointCloudGeometry(inputPly,binaryFile);

    %Runs the Decoder
    dec = decodePointCloudGeometry(binaryFile,outputPly);
    
    % Compute metrics for lossy encoding
    pc = pcread(inputPly);
    V_a = pc.Location;
    pc = pcread(outputPly);
    V_b = pc.Location;

    pt2pt = src_metrics_point_metrics(V_a, V_b);
    
    Rates(i) = enc.rate_bpov;
    MSE(i) = max(pt2pt.p2point_mse);
    PSNR(i) = pt2pt.p2point_psnr;
end