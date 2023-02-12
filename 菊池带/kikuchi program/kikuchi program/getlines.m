function lines = getlines(Image,peaknums,Nhoodsegline)
% 功能：获取线段检测结果
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: Image: 检测得到的边缘图像
%       peaknums: 检测线段数量
%       Nhoodsegline: 检测线段抑制块边长
% 输出: 无
% Return: lines: 得到的线段检测结果
    BW = Image;
    Nhood = [Nhoodsegline,Nhoodsegline];
    peaknum = peaknums;
    [H, theta, rho] = hough(BW);
    P = houghpeaks(H,peaknum,'threshold',ceil(0.18*max(H(:))),'Nhood',Nhood);
    lines = houghlines(BW,theta,rho,P,'FillGap',6,'MinLength',5);
end