function lines = getlines(Image,peaknums,Nhoodsegline)
% ���ܣ���ȡ�߶μ����
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: Image: ���õ��ı�Եͼ��
%       peaknums: ����߶�����
%       Nhoodsegline: ����߶����ƿ�߳�
% ���: ��
% Return: lines: �õ����߶μ����
    BW = Image;
    Nhood = [Nhoodsegline,Nhoodsegline];
    peaknum = peaknums;
    [H, theta, rho] = hough(BW);
    P = houghpeaks(H,peaknum,'threshold',ceil(0.18*max(H(:))),'Nhood',Nhood);
    lines = houghlines(BW,theta,rho,P,'FillGap',6,'MinLength',5);
end