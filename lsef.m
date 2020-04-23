function result = lsef(wavelength,RH,k,m,D,prop)
    %% Computation of light scattering enhancement factors
    % for a given relative humidity (RH)
	% Author: Malandrakis Angelos
    
    %% Function Parameters
	% ------------------------------
	% wavelength: sensor laser wavelength; [double]
    % RH: Relative Humidity [double]
    % k: Hygroscopicity parameter [array]
    % m: Complex refractive index [array]
    % D: particles diameter [array]
    % prop: Probability for light to scater in each type of particles [array]
    % ------------------------------
    
	% mH2O: Water refractive index [double]
    mH2O = 1.3268 + 0.00000338i;
    x = (pi * D)/wavelength;
    
    
    %% Calculate hygroscopic growth and wet parameters
    g = ( 1 + k*(RH/(1-RH)) ).^ (1/3);
    D_wet = g .* D;
    m_wet = ( m + mH2O*(g.^3 - 1) ) ./ (g .^ 3);
    x_wet = (pi * D_wet) / wavelength;
    
    %% Calculate scattering efficiency
	Qsca_dry = zeros(1,length(k));
    Qsca_wet = zeros(1,length(k));
	
    for i = 1:length(k)
        Qsca_dry(i) = Qsca(m(i), x(i));
        Qsca_wet(i) = Qsca(m_wet(i), x_wet(i));
    end
    
    
    %% Result
    f = (D_wet/D) .^ 2 .* (Qsca_wet ./ Qsca_dry);
    result = prop * f';
    
end