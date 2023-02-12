function [Slines,EditImg] = Lines_detect(Img_0,peaknums,Nhoods,canny_sigma,canny_ratio)
% 功能：对于图片中的直线进行检测
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: Img_0: 原始图片
%       peaknums: 检测直线数量
%       Nhoods: 检测直线抑制块边长
%       canny_sigma: Canny算子sigma值
%       canny_ratio: Canny算子高低阈值比
% 输出: 无
% Return: Slines: 检测得到的直线，放在mylines结构体中
%         EditImg: Canny算子边缘检测结果作为结果返回，给getlines函数使用，避免重复运算
    peaknum = peaknums;
    Nhood = [Nhoods,Nhoods];
    if size(Img_0,3) == 3
        Img_0 = rgb2gray(Img_0);
    end
    Img_0 = Img_0 / 2;  %对于初始图片的预处理，不同类型的图片此处使用的方法应该不同
    % 模板窗口的大小一般采用1+2*ceil(3*nSigma) ceil是向上取整函数，例如ceil(0.6)=1
    canny_field = 1+2*ceil(3*canny_sigma);
    EdImg1 = edge_canny(Img_0,[canny_field,canny_field],canny_sigma,0.9,canny_ratio);
    EditImg = EdImg1;
    EdImg_result = EditImg;
    theta = 0:0.5:179.5;
    [R0,rho0] = radon(EdImg_result,theta);
    peaks0 = radonpeaks(R0,peaknum,'Threshold',ceil(0.12*max(R0(:))),'Nhood',Nhood);
    type = 1;
    if type == 1
        lines1 = radonlines(Img_0,theta,rho0',peaks0,type);
    end
    mylines = [];
    for i = 1:length(lines1)
        mylines = [mylines;myLine(lines1(i,1),lines1(i,2),lines1(i,3),lines1(i,4),lines1(i,5))];
    end
    Slines = mylines;
end