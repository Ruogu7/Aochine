%%  Matlab_gTruth_refine
% 使用Matlab 的imageLabeler工具，进行数据标注，得到结果gTruth
% 根据gTruth0506数据，读取影像及其对应的bbox，并显示，以便验证gTruth数据的可靠性。
% 

clear all;
clc
diary '.\path\output_0509_Test_gTruthdata_log.txt'
diary on;
gTruth0508_test = load('gTruth0508_TEST2.mat');
% get path of image
kkk_boat_image = gTruth0508_test.gTruth.DataSource;
kkk_boat_image = kkk_boat_image.Source; % cell结构
size(kkk_boat_image)

% get bbox of image
kkk_boat_bbox = gTruth0508_test.gTruth.LabelData;
% table 格式
%      boat           boat0506
%   {1×2 struct}        true
%   {1×2 struct}        true
%   {2×4 double}        true

kkk_boat_bbox = kkk_boat_bbox.boat;  %% cell 格式, 内容可以是2*4 矩阵，也可以是struct格式
%   {1×2 struct}        
%   {1×2 struct}        
%   {2×4 double}        


jjj = 0;
for iii = 1:size(kkk_boat_image)
    iii
    % get path of image  
    imagePath = kkk_boat_image{iii} % 获取第一个
    imagedataMatrix = imread(imagePath);
    % get bbox
    kkk_boat_bbox_typecheck = kkk_boat_bbox{iii};  %% cell 格式, 内容可以是2*4 矩阵，也可以是struct格式
    if isa(kkk_boat_bbox_typecheck,'struct')     % 当是 struct格式
        kkk_boat_bbox_single = kkk_boat_bbox_typecheck.Position %% 第一个bbox的区域
        % kkk_boat{iii}.LabelUIDs
    else                            % 当是 2*4 矩阵
        jjj = jjj + 1
        kkk_boat_bbox_single = kkk_boat_bbox{iii,1}
        kkk_boat_bbox_single = kkk_boat_bbox_single(1,:)
    end
    
    %% visualization of the image
    figure
    % imshow(imagePath)    
    FirstImage = insertShape(imagedataMatrix,'Rectangle',kkk_boat_bbox_single);  % insertShape函数：根据bbox1的方框信息，插入I1 图像中，形成新的图像；
    imshow(FirstImage)
end

jjj

diary off;