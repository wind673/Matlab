%*******************************(C) COPYRIGHT 2016 Wind��л���죩*********************************%
%{
===========================================================================
@FileName    : PID
@Description : None
@Date        : 2017/7/23
@By          : Wind��л���죩
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}
% ����1 -------------------------------------------------------------------
figure(1);

% �������� ------------------------------------
X_LENTH = 10000;
Main_Sin_Vpp = 60;
Main_Freq = 6; 
g = 9.8;%�������ٶ�

% ���ݲ������� ------------------------------------
x = 1:1:X_LENTH; %0~X_LENTH����1  

input = x*Main_Sin_Vpp;  
real = input; 
%P����
for i = 1:X_LENTH   
    if i < X_LENTH  
        P = -input(i);
        output = P*0.03;
        input(i+1) = input(i) + output;%��һ�ε�ֵ������ε�ֵ + P����
        real(i) = input(i);
    end
end  
y = real;
 
input = x*Main_Sin_Vpp;  
real = input; 
%I����
I = 0;
for i = 1:X_LENTH   
    if i < X_LENTH  
        I = I + 0-input(i);
        output = I*0.01;
        input(i+1) = input(i) + output;%��һ�ε�ֵ������ε�ֵ + P����
        real(i) = input(i);
    end
end  
y1 = real;
 
input = x*Main_Sin_Vpp;  
real = input; 
%D����
D = 0;
for i = 1:X_LENTH   
    if i < X_LENTH  
        if i > 1
            D = input(i)-input(i-1);
        end 
        output = D*0.01;
        input(i+1) = input(i) + output;%��һ�ε�ֵ������ε�ֵ + P����
        real(i) = input(i);
    end
end  
y2 = input;



% ��ͼ���� ------------------------------------
left = 2;
right = 500;
up = Main_Sin_Vpp*2.5;
down = - up;

% subplot(2,1,1);
plot(x,y,'blue'); %��������
hold on;%���� 
plot(x,y1,'red'); %��������
hold on;%���� 
plot(x,y2,'black'); %��������
hold on;%���� 
% plot(x,y4,'blue.'); %��������
% hold on;%���� 
title('P+I+D����');%д����
legend('P','I','D'); 
set(gca,'XLim',[left,right]);%X���������ʾ��Χ
set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',left:(right - left)/10:right);%����X��������
set(gca,'YTick',down:(up - down)/8:up);%����Y��������
hold on;%����
 
% 
% subplot(2,1,2);
% plot(x,y1,'blue'); %��������
% hold on;%���� 
% % plot(x,y2,'red'); %��������
% % hold on;%���� 
% % plot(x,y3,'black'); %��������
% % hold on;%���� 
% % plot(x,y4,'blue.'); %��������
% % hold on;%���� 
% title('PID����','Color','blue');%д����
% set(gca,'XLim',[left,right]);%X���������ʾ��Χ
% set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% % text(950,0,'string');%ͼ������д��
% set(gca,'XTick',left:(right - left)/10:right);%����X��������
% set(gca,'YTick',down:(up - down)/5:up);%����Y��������
% hold on;%����
% 






