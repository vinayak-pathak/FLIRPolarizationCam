%% PART 1
clear;
clc
%% Input I is an image in BayerRG8 format( i.e. not debayered)
sample_idx = 1;
root = "/home/vinayak/Dropbox/FLIRCamDataset/Dataset";

sample_path = [fullfile(root,'Leukemia/1014.tiff'), fullfile(root, 'Malaria/Malaria2.tiff')];
I = imread(sample_path(sample_idx));
samples = ["Leukemia", "Malaria"];
sample_name = samples(sample_idx);
save_path = "/home/vinayak/Dropbox/FLIRCamDataset/Dataset/Newly_Processed";

%% We will be decimating according to the following order in order to obtain the results for each polarization and channel.
r = [1, 2, 3, 4];
c = [1, 2, 3 ,4];

%% Calculating the image size
I1 = uint8(zeros(size(I)));
%% Storing the image height and width
a = size(I1,1)/4;
b = size(I1,2)/4;
%% Each channel from 1:4 will store the Bayered image corresponding to each pattern...

for k = 1:4
    Ipol{k} = uint8(zeros(a*2, b*2));
end


for k = 1:4
    for i = 1:a
        for j = 1:b
    
            if(k==1) % 0
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-3, 4*j-3);%for R
                Ipol{k}(2*i-1, 2*j) = I(4*i-3, 4*j-1);%for G1
                Ipol{k}(2*i, 2*j-1) = I(4*i-1, 4*j-3);%for G2
                Ipol{k}(2*i, 2*j) = I(4*i-1, 4*j-1);%for B
   
    
            elseif(k==2) % 45
                 Ipol{k}(2*i-1, 2*j-1) = I(4*i-3, 4*j-2);
                 Ipol{k}(2*i-1, 2*j) = I(4*i-3, 4*j);
                 Ipol{k}(2*i, 2*j-1) = I(4*i-1, 4*j-2);
                 Ipol{k}(2*i, 2*j) = I(4*i-1, 4*j);

            elseif(k==3) % 90
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-2, 4*j-3);
                Ipol{k}(2*i-1, 2*j) = I(4*i-2, 4*j-1);
                Ipol{k}(2*i, 2*j-1) = I(4*i, 4*j-3);
                Ipol{k}(2*i, 2*j) = I(4*i, 4*j-1);
        
    
            elseif(k==4) % 135
                Ipol{k}(2*i-1, 2*j-1) = I(4*i-2, 4*j-2);
                Ipol{k}(2*i-1, 2*j) = I(4*i-2, 4*j);
                Ipol{k}(2*i, 2*j-1) = I(4*i, 4*j-2);
                Ipol{k}(2*i, 2*j) = I(4*i, 4*j);
            end
        end
    end
end






%%  Gray scale for channel polarization 0 degress;

a = Ipol{1}(1:2:end, 1:2:end);
b = Ipol{1}(2:2:end, 1:2:end);
c = Ipol{1}(1:2:end, 2:2:end);
d = Ipol{1}(2:2:end, 2:2:end);
img0s = double(a)+double(b)+double(c)+double(d)/4;
%figure;imshow(img0s)

%%  Gray scale for channel polarization 45 degress;

a = Ipol{2}(1:2:end, 1:2:end);
b = Ipol{2}(2:2:end, 1:2:end);
c = Ipol{2}(1:2:end, 2:2:end);
d = Ipol{2}(2:2:end, 2:2:end);
img45s = (double(a)+double(b)+double(c)+double(d))/4;
%figure;imshow(img45s)


%%  Gray scale for channel polarization 90 degrees;

a = Ipol{3}(1:2:end, 1:2:end);
b = Ipol{3}(2:2:end, 1:2:end);
c = Ipol{3}(1:2:end, 2:2:end);
d = Ipol{3}(2:2:end, 2:2:end);
img90s = (double(a)+double(b)+double(c)+double(d))/4;
%figure;imshow(img90s)


%%  Gray scale for channel polarization 135 degrees;

a = Ipol{4}(1:2:end, 1:2:end);
b = Ipol{4}(2:2:end, 1:2:end);
c = Ipol{4}(1:2:end, 2:2:end);
d = Ipol{4}(2:2:end, 2:2:end);
img135s = (double(a)+double(b)+double(c)+double(d))/4;
%figure;imshow(img135s)


%% Registering the img4 img3 img2 w.r.t img1;

Img0gs = img0s;
[~, Img45gs] = imregdemons(img45s, img0s);
[~, Img90gs] = imregdemons(img90s, img0s);
[~, Img135gs] = imregdemons(img135s, img0s);

%% Plot degree of polarizations using the registered images for the gray scale images

figure;
dop_gs = sqrt((Img90gs-Img0gs).^2+(Img45gs-Img135gs).^2);

%% Targets

% Total 16 images , 4 gray scale malaria, 4 gray scale Leukimia..

% 4 red leukimia 4 red malaria...
%% Saving the grayscale
%for mat save 
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '0gs.mat'))), 'Img0gs');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '45gs.mat'))), 'Img45gs');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '90gs.mat'))), 'Img90gs');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '135gs.mat'))), 'Img135gs');
imwrite(Img0gs, fullfile(save_path,sample_name, strcat(sample_name, '_0gs.tiff')));
imwrite(Img45gs, fullfile(save_path,sample_name, strcat(sample_name, '_45gs.tiff')));
imwrite(Img90gs, fullfile(save_path,sample_name, strcat(sample_name, '_90gs.tiff')));
imwrite(Img135gs, fullfile(save_path,sample_name, strcat(sample_name, '_135gs.tiff')));

%% Pixel Visualization
histogram(dop_gs)
%% Tail clipping to improve visualization
upper_thresh = 700;
lower_thresh = 60;
dop_gs(dop_gs>upper_thresh) = upper_thresh;

dop_gs(dop_gs<lower_thresh) = lower_thresh;

%% Visualizing the degree of polarization 

figure('Renderer', 'painters', 'Position', [10 10 1200 1200])
dop_gs = 255*(dop_gs - min(dop_gs(:)))./(max(dop_gs(:))-min(dop_gs(:)));
save(fullfile(save_path, sample_name, strcat('dop_gs.mat')), 'dop_gs');
subplot(2, 1, 1)
imagesc(Img0gs)
title(strcat('Grey Scale zero degree pol'," ", sample_name));
axis square
subplot(2, 1, 2)


imagesc(dop_gs)
title(strcat('Degree of polarization'," ", sample_name));
axis square
colorbar

saveas(gca, strcat(fullfile(save_path, sample_name, strcat(sample_name, '_dop.png'))));
%title(fullfile('DOP, sample_name(samp[
%% subplot all the four polarizations after registration
figure('Renderer', 'painters', 'Position', [10 10 1200 1200])
subplot(3, 2, 1)
imagesc(Img0gs)
title("0 degree pol")
axis square
subplot(3, 2, 2)
imagesc(Img45gs)
title("45 degree pol")
axis square
subplot(3, 2, 3)
imagesc(Img90gs)
title("90 degree pol")
axis square
subplot(3, 2, 4)
imagesc(Img135gs)
title("135 degree pol")
axis square
subplot(3, 2, 5)
imagesc(dop_gs)
title("Degree of Polarization")
axis square
subplot(3, 2, 6)
imshowpair(dop_gs, Img0gs)
axis square
title("Overlay")
sgtitle('Gray Scale')

saveas(gca, strcat(fullfile(save_path, sample_name, strcat(sample_name, '_Polarization_map_grayscale.png'))));



%% Red Channel Corresponding to four channels

img0r = double(Ipol{1}(1:2:end, 1:2:end));

img45r = double(Ipol{2}(1:2:end, 1:2:end));

img90r = double(Ipol{3}(1:2:end, 1:2:end));

img135r = double(Ipol{4}(1:2:end, 1:2:end));

%% Reading images
Img0r = img0r;
[~, Img45r] = imregdemons(img45r, img0r);

[~, Img90r] = imregdemons(img90r, img0r);

[~, Img135r] = imregdemons(img135r, img0r);

%% Calculating degree of polarization
dop_red =sqrt((Img90r - Img0r).^2+(Img45r - Img135r).^2);

%% Removing edge high intensity values
figure;
histogram(dop_red(:)) % Histogram visualization and cuttoff

%% clip the pixels off at the right tail to better visualize the resulting image( here ~thres = 50 choosen manually, by visualizing the histogram, feel free to change the threshold)
%threshr = 50; %Malaria
threshr = 50;% Leukemia
dop_red(dop_red(:)>threshr) = threshr; 
% or dop_red(dop_red(:)>50) = NaN;% not choosen for normalisation as they will contribute to noise...


%% Saving the red channel

%for mat save 
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '0r.mat'))), 'Img0r');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '45r.mat'))), 'Img45r');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '90r.mat'))), 'Img90r');
save(char(fullfile(save_path,sample_name, strcat(sample_name,  '135r.mat'))), 'Img135r');
imwrite(Img0r, fullfile(save_path,sample_name, strcat(sample_name, '_0r.tiff')));
imwrite(Img45r, fullfile(save_path,sample_name, strcat(sample_name, '_45r.tiff')));
imwrite(Img90r, fullfile(save_path,sample_name, strcat(sample_name, '_90r.tiff')));
imwrite(Img135r, fullfile(save_path,sample_name, strcat(sample_name, '_135r.tiff')));

%% Visualing DOP and red channel corresponding to each polarization

%% Visualizing the degree of polarization 

figure('Renderer', 'painters', 'Position', [10 10 1200 1200])
dop_red = 255*(dop_red - min(dop_red(:)))./(max(dop_red(:))-min(dop_red(:)));
save(fullfile(save_path, sample_name,strcat('dop_red.mat')), 'dop_red');
subplot(2, 1, 1)
imshow(uint8(Img0r))
title(strcat('Red Channel zero degree pol'," ", sample_name))
axis square
subplot(2, 1, 2)
imagesc(dop_red)
axis square
colorbar

title(strcat('Degree of polarization red channel'," ", sample_name));
saveas(gca, strcat(fullfile(save_path, sample_name, strcat(sample_name, '_dop_red.png'))));
%title(fullfile('DOP, sample_name(samp[
%% subplot all the four polarizations after registration
figure('Renderer', 'painters', 'Position', [10 10 1200 1200])
subplot(3, 2, 1)
imagesc(Img0r)
title("0 degree pol")
axis square
subplot(3, 2, 2)
imagesc(Img45r)
title("45 degree pol")
axis square
subplot(3, 2, 3)
imagesc(Img90r)
title("90 degree pol")
axis square
subplot(3, 2, 4)
imagesc(Img135r)
title("135 degree pol")
axis square
subplot(3, 2, 5)
imagesc(dop_red)
title("Degree of Polarization")
axis square
subplot(3, 2, 6)
imshowpair(dop_red, Img0r)
axis square
title("Overlay")
sgtitle('Red Channel')

saveas(gca, strcat(fullfile(save_path, sample_name, strcat(sample_name, '_Polarization_map_red.png'))));



%% PART 2

%% Visualized Demosaiced from each polarization
figure;
klist = [1, 2, 3, 4];
heading = ["0 pol", "45 pol", "90 pol", "135 pol"];
for k =1:4
    subplot(2, 2, klist(k))
    imshow(demosaic(Ipol{k},'rggb'))
    title(heading(k));
    sgtitle(sample_name);
end
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