clc;
clear all;
close all;
warning off

%% Global parameters
scene_all = {'mini_balls' 'plastic_bottle' 'metallic_bottle' 'candies' 'chart_b' 'chart_r' 'chart_w' 'cisors' 'colorchecker' 'cutter' 'electronic'...
    'inkwell' 'painting_1' 'painting_2' 'pens' 'plastic_1' 'plier' 'polarizer' 'resin_balls' 'screwdriver' 'tape' 'toy_1' 'toy_2' 'toy_3' 'vernier' 'wood_1' 'wood_2' 'wood_3'};
% Select one scene among all or all (scene_all):
scene = scene_all;% scene_all or 'colorchecker';
load('Misc/norm_factors.mat')

for j=1:size(scene,2)
    %% Load images
    for i=1:4
        bg(:,:,:,i) = im2double(imread(['Data/bg_' scene{j} '.tif'],i));
        y(:,:,:,i) = im2double(imread(['Data/y_' scene{j} '.tif'],i));
    end

    %% Montage of the images
    ms = cat(3,bg,y);
    ms(isinf(ms))=1;
    ms = ms./reshape(norm_factors,1,1,6);

    %% Stokes computation
    S(:,:,:,1) = (ms(:,:,:,1) + ms(:,:,:,3));
    S(:,:,:,2) = ms(:,:,:,1) - ms(:,:,:,3);
    S(:,:,:,3) = ms(:,:,:,2,:) - ms(:,:,:,4,:);
    S = single(S);

    S0_unpol = single(S(:,:,:,1)-sqrt(S(:,:,:,2).^2+S(:,:,:,3).^2));

    %% Visualization of S0 images
    montage((S(:,:,:,1)),'DisplayRange',[0 2]);
    colorbar;
    title('S0 images');

    %% Save
    save(['Stokes_Result/S_' scene{j} '.mat'],'S');
    save(['Stokes_Result/S0_unpol_' scene{j} '.mat'],'S0_unpol');
end
