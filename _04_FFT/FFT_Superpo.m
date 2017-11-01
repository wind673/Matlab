%*******************************(C) COPYRIGHT 2016 Wind（谢玉伸）*********************************%
%{
===========================================================================
@FileName    : FFT
@Description : FFT叠加运算
@Date        : 2017/7/27
@By          : Wind（谢玉伸）
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}
fprintf("\n\n\n\n\n\n"); 

% 窗口1 -------------------------------------------------------------------
% 参数设置 ------------------------------------
SIN_CNT = 8;%基波
SIN_POINT = 256;
X_LENTH = SIN_CNT*SIN_POINT;

x = 0:1:X_LENTH; %0~X_LENTH步进1 
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


fprintf("\nFFT法*******************************");  
Vpp = x*0;
Ipp = x*0;
for i = 1:X_LENTH
    Vpp(i) = sqrt(imag(fft1(i))*imag(fft1(i)) + real(fft1(i))*real(fft1(i)))*4/X_LENTH;
    Ipp(i) = sqrt(imag(fft2(i))*imag(fft2(i)) + real(fft2(i))*real(fft2(i)))*4/X_LENTH;
end   

% fprintf("\n有效值 ----------------------------\n"); 
% Vrms = 0;
% Irms = 0;
% for i = 1:X_LENTH
%     
% end  
% Vrms = sqrt(Vrms/X_LENTH);
% Irms = sqrt(Irms/X_LENTH); 
% fprintf("Vrms = %0.4fV   Irms = %0.4fV\n",Vrms,Irms); 

fprintf("\n相位差 ----------------------------\n"); 
phase1 = x*0;
phase2 = x*0;
phase  = x*0;
for i = 1:X_LENTH
     phase1(i) = atan2(imag(fft1(i)),real(fft1(i)))*360/2/pi;
     phase2(i) = atan2(imag(fft2(i)),real(fft2(i)))*360/2/pi;
     phase(i)  = phase1(i) - phase2(i);  
end  
fprintf("phase1 =  %0.4f° \n",phase(SIN_CNT+1));    
fprintf("phase2 =  %0.4f° \n",phase(SIN_CNT*3+1));  
fprintf("phase3 =  %0.4f° \n",phase(SIN_CNT*5+1));  
%结论：角度互相独立，频率相同可直接加减(基波必须最大才成立)
 
fprintf("\n有功功率 ----------------------------\n"); 
Py1 = (Vpp(SIN_CNT+1)*Ipp(SIN_CNT+1)/2*cos(phase(SIN_CNT+1)*2*pi/360));
Py2 = (Vpp(SIN_CNT*3+1)*Ipp(SIN_CNT*3+1)/2*cos(phase(SIN_CNT*3+1)*2*pi/360));
Py3 = (Vpp(SIN_CNT*5+1)*Ipp(SIN_CNT*5+1)/2*cos(phase(SIN_CNT*5+1)*2*pi/360));
Py = Py1+Py2+Py3;

fprintf("Py1 = %0.4fW \n",Py1); 
fprintf("Py2 = %0.4fW \n",Py2); 
fprintf("Py3 = %0.4fW \n",Py3); 
fprintf("Py1+Py2+Py3 = %0.4fW \n",Py); 




fprintf("\n积分法*******************************"); 
fprintf("\n有效值 ----------------------------\n"); 
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
fprintf("\n有功功率 ----------------------------\n"); 
fprintf("Py1 = %0.4fW \n",Py1);  
fprintf("Py2 = %0.4fW \n",Py2);  
fprintf("Py3 = %0.4fW \n",Py3);  
fprintf("Py1+Py2+Py3 = %0.4fW \n",Py1+Py2+Py3);  

Ps = Vrms * Irms;%视在功率
fprintf("Py = %0.4fW \n",Py); 
fprintf("Ps = %0.4fW \n",Ps); 
fprintf("Pf = %0.4f \n",Py/Ps); 

Phase = acos(Py/Ps)*360/2/pi;
fprintf("Phase = %0.4f \n",Phase); 
%结论：有功功率互相独立，相同频率可直接加减 




% 画图处理 ------------------------------------ 
figure(1); 

subplot(2,1,1);
plot(x,V,'blue'); %画出波形
hold on;%保持  
plot(x,I,'red'); %画出波形
hold on;%保持   
title('ADC');%写标题
legend('电压','电流');  
hold on;%保持 
grid;
 
subplot(2,1,2);
plot(x,Vpp,'blue'); %画出波形
hold on;%保持  
plot(x,Ipp,'red'); %画出波形
hold on;%保持   
plot(x,phase,'black'); %画出波形
hold on;%保持  
set(gca,'XLim',[0,X_LENTH]);%X轴的数据显示范围
set(gca,'YLim',[-360,360]);%Y轴的数据显示范围
title('FFT');%写标题
legend('电压','电流','相位差');  
hold on;%保持 
grid;
 
