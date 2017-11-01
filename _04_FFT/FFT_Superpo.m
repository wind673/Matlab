%*******************************(C) COPYRIGHT 2016 Wind��л���죩*********************************%
%{
===========================================================================
@FileName    : FFT
@Description : FFT��������
@Date        : 2017/7/27
@By          : Wind��л���죩
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}
fprintf("\n\n\n\n\n\n"); 

% ����1 -------------------------------------------------------------------
% �������� ------------------------------------
SIN_CNT = 8;%����
SIN_POINT = 256;
X_LENTH = SIN_CNT*SIN_POINT;

x = 0:1:X_LENTH; %0~X_LENTH����1 
pv1 = 0;
pv2 = 10;
pv3 = 0;
V1 = sin(x*pi*2*SIN_CNT/X_LENTH+pv1/360*pi*2)*2.0;
V2 = sin(x*pi*2*SIN_CNT*3/X_LENTH+pv2/360*pi*2)*0.2;
V3 = sin(x*pi*2*SIN_CNT*5/X_LENTH+pv3/360*pi*2)*0.3;
V = V1+V2+V3;

pi1 = 65;
pi2 = 55;
pi3 = 30;
I1 = sin(x*pi*2*SIN_CNT/X_LENTH+pi1/360*pi*2)*2.0;
I2 = sin(x*pi*2*SIN_CNT*3/X_LENTH+pi2/360*pi*2)*0.1;
I3 = sin(x*pi*2*SIN_CNT*5/X_LENTH+pi3/360*pi*2)*0.2;
I = I1+I2+I3;
fft1 = fft(V); 
fft2 = fft(I); 


fprintf("\nFFT��*******************************");  
Vpp = x*0;
Ipp = x*0;
for i = 1:X_LENTH
    Vpp(i) = sqrt(imag(fft1(i))*imag(fft1(i)) + real(fft1(i))*real(fft1(i)))*4/X_LENTH;
    Ipp(i) = sqrt(imag(fft2(i))*imag(fft2(i)) + real(fft2(i))*real(fft2(i)))*4/X_LENTH;
end   

% fprintf("\n��Чֵ ----------------------------\n"); 
% Vrms = 0;
% Irms = 0;
% for i = 1:X_LENTH
%     
% end  
% Vrms = sqrt(Vrms/X_LENTH);
% Irms = sqrt(Irms/X_LENTH); 
% fprintf("Vrms = %0.4fV   Irms = %0.4fV\n",Vrms,Irms); 

fprintf("\n��λ�� ----------------------------\n"); 
phase1 = x*0;
phase2 = x*0;
phase  = x*0;
for i = 1:X_LENTH
     phase1(i) = atan2(imag(fft1(i)),real(fft1(i)))*360/2/pi;
     phase2(i) = atan2(imag(fft2(i)),real(fft2(i)))*360/2/pi;
     phase(i)  = phase1(i) - phase2(i);  
end  
fprintf("phase1 =  %0.4f�� \n",phase(SIN_CNT+1));    
fprintf("phase2 =  %0.4f�� \n",phase(SIN_CNT*3+1));  
fprintf("phase3 =  %0.4f�� \n",phase(SIN_CNT*5+1));  
%���ۣ��ǶȻ��������Ƶ����ͬ��ֱ�ӼӼ�(�����������ų���)
 
fprintf("\n�й����� ----------------------------\n"); 
Py1 = (Vpp(SIN_CNT+1)*Ipp(SIN_CNT+1)/2*cos(phase(SIN_CNT+1)*2*pi/360));
Py2 = (Vpp(SIN_CNT*3+1)*Ipp(SIN_CNT*3+1)/2*cos(phase(SIN_CNT*3+1)*2*pi/360));
Py3 = (Vpp(SIN_CNT*5+1)*Ipp(SIN_CNT*5+1)/2*cos(phase(SIN_CNT*5+1)*2*pi/360));
Py = Py1+Py2+Py3;

fprintf("Py1 = %0.4fW \n",Py1); 
fprintf("Py2 = %0.4fW \n",Py2); 
fprintf("Py3 = %0.4fW \n",Py3); 
fprintf("Py1+Py2+Py3 = %0.4fW \n",Py); 




fprintf("\n���ַ�*******************************"); 
fprintf("\n��Чֵ ----------------------------\n"); 
Vrms = 0;
Irms = 0;
for i = 1:X_LENTH 
    Vrms = Vrms + V(i)*V(i);   
    Irms = Irms + I(i)*I(i);
end
Vrms = sqrt(Vrms /X_LENTH)*2;
Irms = sqrt(Irms /X_LENTH)*2;
fprintf("Vrms = %0.4fV  Irms = %0.4fV\n",Vrms,Irms);

Py = 0;
Py1 = 0;
Py2 = 0;
Py3 = 0;
for i = 1:X_LENTH 
    Py = Py + V(i)*I(i)*4/X_LENTH;   
    Py1 = Py1 + V(i)*I1(i)*4/X_LENTH;     
    Py2 = Py2 + V(i)*I2(i)*4/X_LENTH;   
    Py3 = Py3 + V(i)*I3(i)*4/X_LENTH;    
end
fprintf("\n�й����� ----------------------------\n"); 
fprintf("Py1 = %0.4fW \n",Py1);  
fprintf("Py2 = %0.4fW \n",Py2);  
fprintf("Py3 = %0.4fW \n",Py3);  
fprintf("Py1+Py2+Py3 = %0.4fW \n",Py1+Py2+Py3);  

Ps = Vrms * Irms;%���ڹ���
fprintf("Py = %0.4fW \n",Py); 
fprintf("Ps = %0.4fW \n",Ps); 
fprintf("Pf = %0.4f \n",Py/Ps); 

Phase = acos(Py/Ps)*360/2/pi;
fprintf("Phase = %0.4f \n",Phase); 
%���ۣ��й����ʻ����������ͬƵ�ʿ�ֱ�ӼӼ� 




% ��ͼ���� ------------------------------------ 
figure(1); 

subplot(2,1,1);
plot(x,V,'blue'); %��������
hold on;%����  
plot(x,I,'red'); %��������
hold on;%����   
title('ADC');%д����
legend('��ѹ','����');  
hold on;%���� 
grid;
 
subplot(2,1,2);
plot(x,Vpp,'blue'); %��������
hold on;%����  
plot(x,Ipp,'red'); %��������
hold on;%����   
plot(x,phase,'black'); %��������
hold on;%����  
set(gca,'XLim',[0,X_LENTH]);%X���������ʾ��Χ
set(gca,'YLim',[-360,360]);%Y���������ʾ��Χ
title('FFT');%д����
legend('��ѹ','����','��λ��');  
hold on;%���� 
grid;
 
