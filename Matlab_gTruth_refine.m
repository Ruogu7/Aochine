%%  Matlab_gTruth_refine
% ʹ��Matlab ��imageLabeler���ߣ��������ݱ�ע���õ����gTruth
% ����gTruth0506���ݣ���ȡӰ�����Ӧ��bbox������ʾ���Ա���֤gTruth���ݵĿɿ��ԡ�
% 

clear all;
clc
diary '.\path\output_0509_Test_gTruthdata_log.txt'
diary on;
gTruth0508_test = load('gTruth0508_TEST2.mat');
% get path of image
kkk_boat_image = gTruth0508_test.gTruth.DataSource;
kkk_boat_image = kkk_boat_image.Source; % cell�ṹ
size(kkk_boat_image)

% get bbox of image
kkk_boat_bbox = gTruth0508_test.gTruth.LabelData;
% table ��ʽ
%      boat           boat0506
%   {1��2 struct}        true
%   {1��2 struct}        true
%   {2��4 double}        true

kkk_boat_bbox = kkk_boat_bbox.boat;  %% cell ��ʽ, ���ݿ�����2*4 ����Ҳ������struct��ʽ
%   {1��2 struct}        
%   {1��2 struct}        
%   {2��4 double}        


jjj = 0;
for iii = 1:size(kkk_boat_image)
    iii
    % get path of image  
    imagePath = kkk_boat_image{iii} % ��ȡ��һ��
    imagedataMatrix = imread(imagePath);
    % get bbox
    kkk_boat_bbox_typecheck = kkk_boat_bbox{iii};  %% cell ��ʽ, ���ݿ�����2*4 ����Ҳ������struct��ʽ
    if isa(kkk_boat_bbox_typecheck,'struct')     % ���� struct��ʽ
        kkk_boat_bbox_single = kkk_boat_bbox_typecheck.Position %% ��һ��bbox������
        % kkk_boat{iii}.LabelUIDs
    else                            % ���� 2*4 ����
        jjj = jjj + 1
        kkk_boat_bbox_single = kkk_boat_bbox{iii,1}
        kkk_boat_bbox_single = kkk_boat_bbox_single(1,:)
    end
    
    %% visualization of the image
    figure
    % imshow(imagePath)    
    FirstImage = insertShape(imagedataMatrix,'Rectangle',kkk_boat_bbox_single);  % insertShape����������bbox1�ķ�����Ϣ������I1 ͼ���У��γ��µ�ͼ��
    imshow(FirstImage)
end

jjj

diary off;