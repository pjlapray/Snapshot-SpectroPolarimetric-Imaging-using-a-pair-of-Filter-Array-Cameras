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

for j=1:size(scene,2)
    %% Load images
    load(['Stokes_Result/S_' scene{j}])
    load(['Stokes_Result/S0_unpol_' scene{j}])

    %% Montage of the images
    ms_S0 = S(:,:,:,1);ms_I_unpol = S0_unpol;
    MS_S0 = reshape(ms_S0,size(ms_S0,1)*size(ms_S0,2),6);
    MS_I_unpol = reshape(ms_I_unpol,size(ms_I_unpol,1)*size(ms_I_unpol,2),6);
    MS_S0 = permute(MS_S0,[2 1]);MS_I_unpol = permute(MS_I_unpol,[2 1]);

    %% Load calibration matrix (N->M transformation)
    load('Misc/M_s.mat')

    %% Generate radiance images by polarization channel
    display('Generating...');
    R_S0 = single(M_s*MS_S0(:,:));
    R_I_unpol = single(M_s*MS_I_unpol(:,:));
    R_S0 = reshape(R_S0',size(ms_S0,1),size(ms_S0,2),size(R_S0,1));
    R_I_unpol = reshape(R_I_unpol',size(ms_S0,1),size(ms_S0,2),size(R_I_unpol,1));

    save(['Spectral_Result/reflectance_S0_' scene{j} '.mat'],'R_S0','-v7.3','-nocompression');
    save(['Spectral_Result/reflectance_S0_unpol_' scene{j} '.mat'],'R_I_unpol','-v7.3','-nocompression');

    montage(R_S0);colormap('jet');title('Reflectance images, 380-730nm')
end