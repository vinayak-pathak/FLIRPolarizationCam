clear all
clc
%% Short version of code
%% Input I is a bayered image( i.e. not debayered)
filepath = '/home/vinayak/Dropbox/FLIRCamDataset/Dataset';
presentation = '/home/vinayak/Dropbox/FLIRCamDataset/Presentation';
filename = 'Malaria2.tiff';
I = imread(fullfile(filepath, filename));
sample_name = 'Malaria' ;
sampleid   = filename(1:end-5);
%% 
dx = 2;


r = [1, 2, 3, 4];
c = [1, 2, 3 ,4];
%% Image size
Img = I(1:dx:end, 1:dx:end);
%%
I1 = uint8(zeros(size(Img)));
%% 
a = size(I1,1)/2;
b = size(I1,2)/2;
%% Create a bayered pattern for each polarization

for k = 1:4
    Ipol{k} = I1;
end
%%
% for i = 1:
%     for j = 1:
%     end
% end
for k = 1:4
    for i = 1:a
        for j = 1:b
    
            if(k==1)
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-3, 4*j-3);%for R
                Ipol{k}(2*i-1, 2*j) = I(4*i-3, 4*j-1);%for G1
                Ipol{k}(2*i, 2*j-1) = I(4*i-1, 4*j-3);%for G2
                Ipol{k}(2*i, 2*j) = I(4*i-1, 4*j-1);%for B
   
    
            elseif(k==2)
                 Ipol{k}(2*i-1, 2*j-1) = I(4*i-3, 4*j-2);
                 Ipol{k}(2*i-1, 2*j) = I(4*i-3, 4*j);
                 Ipol{k}(2*i, 2*j-1) = I(4*i-1, 4*j-2);
                 Ipol{k}(2*i, 2*j) = I(4*i-1, 4*j);

            elseif(k==3)
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-2, 4*j-3);
                Ipol{k}(2*i-1, 2*j) = I(4*i-2, 4*j-1);
                Ipol{k}(2*i, 2*j-1) = I(4*i, 4*j-3);
                Ipol{k}(2*i, 2*j) = I(4*i, 4*j-1);
        
    
            elseif(k==4)
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-2, 4*j-2);
                Ipol{k}(2*i-1, 2*j) = I(4*i-2, 4*j);
                Ipol{k}(2*i, 2*j-1) = I(4*i, 4*j-2);
                Ipol{k}(2*i, 2*j) = I(4*i, 4*j);
            end
        end
    end
end




%% Visualized Demosaiced from each polarization
figure;
klist = [1, 2, 3, 4];
heading = ["0 pol", "45 pol", "90 pol", "135 pol"];
for k =1:4
    subplot(2, 2, klist(k))
    imshow(demosaic(Ipol{k},'rggb'))
    img = demosaic(Ipol{k},'rggb');
    filesavepath = fullfile(presentation, [sample_name heading(k) ".mat"]);
    filesavepath = convertStringsToChars(filesavepath);
    tit = sprintf('%ssample%s.mat', sample_name, heading(k));
    save(tit, 'img');
    title(heading(k));
    sgtitle(sample_name);
    
end
saveas(gca, fullfile(presentation,[sampleid '_rgb' '.tiff']))
%% Visualize colour channel wise

for k = 1:4
    Ipolcolor{k} = demosaic(Ipol{k}, 'rggb');
end
%%

for channels = 1:3
    figure;
    for k = 1:4
    
    subplot(2, 2, klist(k))
    imshow(Ipolcolor{k}(:, :, channels))
    title(heading(k));
    end
    titchannel = sprintf(' Channel %d', channels);
    sgtitle([sample_name titchannel]);
    saveas(gca, fullfile(presentation,[sampleid '_channel' num2str(channels) '.tiff']))
end
%% --- END ----
%% Expanded Version of above code
%% All Red
Ir0 = I(1:dx:end, 1:dx:end);
Ir45 = I(1:dx:end, 2:dx:end);
Ir90 = I(2:dx:end, 1:dx:end);
Ir135 = I(2:dx:end, 2:dx:end);
% Plotting red channels
figure;
subplot(2, 2, 1)
imshow(Ir0)
subplot(2, 2, 2)
imshow(Ir45)
subplot(2, 2, 3)
imshow(Ir90)
subplot(2, 2, 4)
imshow(Ir135)
%%


%% All Green 1
Ig10 = I(1:dx:end, 3:dx:end);
Ig145 = I(1:dx:end, 4:dx:end);
Ig190 = I(2:dx:end, 3:dx:end);
Ig1135 = I(2:dx:end, 4:dx:end);
% Plotting red channels
figure;
subplot(2, 2, 1)
imshow(Ig10)
subplot(2, 2, 2)
imshow(Ig145)
subplot(2, 2, 3)
imshow(Ig190)
subplot(2, 2, 4)
imshow(Ig1135)

%% All Green 2
Ig20 = I(3:dx:end, 1:dx:end);
Ig245 = I(3:dx:end, 2:dx:end);
Ig290 = I(4:dx:end, 1:dx:end);
Ig2135 = I(4:dx:end, 2:dx:end);
% Plotting red channels
figure;
subplot(2, 2, 1)
imshow(Ig20)
subplot(2, 2, 2)
imshow(Ig245)
subplot(2, 2, 3)
imshow(Ig290)
subplot(2, 2, 4)
imshow(Ig2135)

%% All Blue


Ib0 = I(3:dx:end, 3:dx:end);
Ib45 = I(3:dx:end, 4:dx:end);
Ib90 = I(4:dx:end, 3:dx:end);
Ib135 = I(4:dx:end, 4:dx:end);
% Plotting red channels
figure;
subplot(2, 2, 1)
imshow(Ib0)
subplot(2, 2, 2)
imshow(Ib45)
subplot(2, 2, 3)
imshow(Ib90)
subplot(2, 2, 4)
imshow(Ib135)

%% Color Plot
Icolor0 = uint8(zeros([size(Ib0), 3]));
Icolor45 = uint8(zeros([size(Ib0), 3]));
Icolor90 = uint8(zeros([size(Ib0), 3]));
Icolor135 = uint8(zeros([size(Ib0), 3]));
%% Developing the color plot
Icolor0(:, :, 1) = Ir0;
Icolor0(:, :, 2) = 0.5*Ig10 + 0.5*Ig20;
Icolor0(:, :, 3) = Ib0;


Icolor45(:, :, 1) = Ir45;
Icolor45(:, :, 2) = 0.5*Ig145 + 0.5*Ig245;
Icolor45(:, :, 3) = Ib45;

Icolor90(:, :, 1) = Ir90;
Icolor90(:, :, 2) = 0.5*Ig190 + 0.5*Ig290;
Icolor90(:, :, 3) = Ib90;

Icolor135(:, :, 1) = Ir135;
Icolor135(:, :, 2) = 0.5*Ig1135 + 0.5*Ig2135;
Icolor135(:, :, 3) = Ib135;

%% Visualizing the color plot;



%% Developing the color plot
figure
subplot(2, 2, 1)
imshow(Icolor0);
subplot(2, 2, 2)

imshow(Icolor45);
subplot(2, 2, 3)
imshow(Icolor90);
subplot(2, 2, 4)
imshow(Icolor135);