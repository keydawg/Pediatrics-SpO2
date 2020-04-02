files = dir('*SpO2.csv');
files = {files.name};
figure
hold on;
for i = 1:length(files)
   
       % A = dlmread (files{i},',',1,2);
        A = readtable (files{i});
        D{i}.Data = table2array(A(:,3));
        B = table2array(A(:,2));
        D{i}.Time = datetime(B,'InputFormat','yyyy-MM-dd hh:mm:ss');
        D{i}.Time = D{i}.Time - min(D{i}.Time);
        plot(D{i}.Time,D{i}.Data);
        drawnow;
end


%%

close all;
figure;
O=[0,0,1,1,0,0,1,1,0,1,1];
k=[1,3,2,4,5,7,6,10,9,11];
for i = [1:10]
  %  figure;
     subplot(5,2,i)
%     plot(D{i}.Time,D{i}.Data)
%     subplot(2,1,2)
    A = D{k(i)}.Data;
    B=[];
    for j = 20:length(A)
        B(j)=(sum((mean(A(j-19:j))-A(j-19:j)).^2)/20).^0.5;
    end
   % plot(B);
    
   % figure;
    Fs = 1/5;
    [b,a]=butter(1,0.02/(Fs/2));
    
    [s,w,t] = spectrogram(filtfilt(b,a,detrend(A(Fs*60*60:Fs*60*60*20),'constant')),[256],[250],[0.00001:0.0001:0.005],Fs);
    imagesc(t/60,w,abs(s),[0 500]); set(gca,'ydir','normal');
    xlabel('time, min');
    ylabel('frequenxy, Hz');
    drawnow;
end

%%
% Fs = 1/5;
% [s,w,t] = spectrogram(detrend(A,'constant'),[256],[254],[0.001:0.001:0.03],Fs);
% imagesc(t,w,abs(s)); set(gca,'ydir','normal');