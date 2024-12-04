function [R_scaled,Theta,Xp_cm, AttenuationImage]=simulate_parallelbeam(Img,muWater,muAir,p_cm)
% [R_scaled,Theta,Xp_cm, AttenuationImage]=simulate_parallelbeam(Img,muWater,muAir,p_cm)
%
% Img     = Original Chicken slice
% muWater = Water value from matching QC phantom image
% muAir   = Air value from matching QC phantom image
% p_cm    = pixel spacing of CT data in [cm] (watch units!) 
%
% R_scaled = radon transform image (unitless)
% Theta    = projection angles
% Xp_cm    = detector element position [cm]
% AttenuationImage = Chicken image in simulated linear attenuation coefficient [1/cm]

dWater=muWater-muAir;  % effective value
mu_water=0.36;  % [1/cm]
ImgN=Img-muAir;
ImgN(ImgN<0)=0; % Zero the air (a better thing would be to put in the real value for attenuation of air)
AttenuationImage=ImgN/dWater*mu_water;  % Turn it to linear attenuation

dtheta=0.5;
Theta=0:dtheta:(180-dtheta);
[R,Xp]=radon(Img,Theta);
R_scaled= R.*p_cm;
Xp_cm=Xp.*p_cm;