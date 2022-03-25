clc;
clear all;
close all;
warning off
addpath(genpath('../Toolbox/'))

%% Global parameters
scene_all = {'mini_balls' 'plastic_bottle' 'metallic_bottle' 'candies' 'chart_b' 'chart_r' 'chart_w' 'cisors' 'colorchecker' 'cutter' 'electronic'...
    'inkwell' 'painting_1' 'painting_2' 'pens' 'plastic_1' 'plier' 'polarizer' 'resin_balls' 'screwdriver' 'tape' 'toy_1' 'toy_2' 'toy_3' 'vernier' 'wood_1' 'wood_2' 'wood_3'};
% Select one scene among all or all (scene_all):
scene = scene_all;% scene_all or 'colorchecker';
load('Misc/norm_factors.mat')
range = 380:10:730;

%% Load images
for j=1:size(scene,2)
    %% Load images
    load(['Spectral_Result/reflectance_S0_' scene{j}])
    load(['Spectral_Result/reflectance_S0_unpol_' scene{j}])

    %% XYZ
    cmf_r = readmatrix('Misc/ciexyz31.csv');% From CVRL website
    C = cmf_r(5:75,2:4);
    C = interp1(380:5:730,C,range);
    R_S0_r = reshape(R_S0,size(R_S0,1)*size(R_S0,2),36);
    xyz = (C'*R_S0_r')*100/sum(C(:,2));
    xyz = xyz./max(max(xyz));
    rgb = xyz2rgb(xyz','ColorSpace','linear-rgb','WhitePoint','e');
    rgb_3D = reshape(rgb,size(R_S0,1),size(R_S0,2),3);
    rgb2 = double(rgb)*2;
    srgb = lin2rgb(rgb2); % to srgb
    srgb = reshape(srgb,size(R_S0,1),size(R_S0,2),3 ...
        );
    im = reshape(srgb,size(R_S0,1),size(R_S0,2),3);

    imwrite(srgb,['Color_Result/srgb_' scene{j} '.tif']);
    
    imshow(srgb(:,:,:));
end
