 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 
entity SmartIrrigationSystem is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        -- Connect the input ports of each block here
        Temps_manuelle : in STD_LOGIC_VECTOR(2 downto 0);
        Capteur_Temp : in STD_LOGIC_VECTOR(4 downto 0);
        Capteur_Hum : in STD_LOGIC_VECTOR(6 downto 0);
        Seuils_Hum : in STD_LOGIC_VECTOR(13 downto 0);
        Seuil_Temp : in STD_LOGIC_VECTOR(4 downto 0);
        I_manuelle : in STD_LOGIC;
        Capteur_Niveau_Eau : in STD_LOGIC;
        Capteur_pH : in STD_LOGIC_VECTOR(2 downto 0);

        alarme_HI : out STD_LOGIC;
        alarme_HS : out STD_LOGIC;
        alarme_T : out STD_LOGIC;
        alarme_NE : out STD_LOGIC;
        alarme_PH : out STD_LOGIC;
        ventilo : out STD_LOGIC;
        pompe : out STD_LOGIC;
        fin : out STD_LOGIC
        -- Define other connections here
    );
end SmartIrrigationSystem;

architecture Behavioral of SmartIrrigationSystem is
    signal Refroidir_BlockTemps, Refroidir_Surveillance, Irriguer_Surveillance, Irriguer_BlockTemps : STD_LOGIC;
    signal pompe_actif, ventilo_actif, capteur_NE : STD_LOGIC;
    signal Alarme_NE_BlockSurveillance, Alarme_HS_Surveillance, Alarme_HI_Surveillance, Alarme_T_Surveillance, Alarme_PH_BlockControle : STD_LOGIC;
    signal pompe_actif_BlockAct, ventilo_actif_BlockAct : STD_LOGIC;
    signal FIN_BlockAct, POMPE_BlockAct, VENTILO_BlockAct : STD_LOGIC := '0';

	 component Bloc_temps
	 Port (
        -- Inputs
        Temps_manuelle : in STD_LOGIC_VECTOR(2 downto 0);
        Capteur_Temp : in STD_LOGIC_VECTOR(4 downto 0);
        Capteur_Hum : in STD_LOGIC_VECTOR(6 downto 0);
        Seuils_Hum : in STD_LOGIC_VECTOR(13 downto 0);
        Seuil_Temp : in STD_LOGIC_VECTOR(4 downto 0);
        I_manuelle : in STD_LOGIC;
        Refroidir : in STD_LOGIC;
        Irriguer : in STD_LOGIC;
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;

        -- Outputs
        Pompe_actif : out STD_LOGIC;
        Ventilo_actif : out STD_LOGIC
    );
	 end component;
	 component Bloc_surveillance
	 Port(
        -- Inputs
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        Capteur_Temp : in STD_LOGIC_VECTOR(4 downto 0);
        Capteur_Hum : in STD_LOGIC_VECTOR(6 downto 0);
        Seuils_Hum : in STD_LOGIC_VECTOR(13 downto 0);
        Seuil_Temp : in STD_LOGIC_VECTOR(4 downto 0);

        -- Outputs (updated names to avoid conflicts)
        Alarme_T_Surveillance : out STD_LOGIC;
        Alarme_HI_Surveillance : out STD_LOGIC;
        Alarme_HS_Surveillance : out STD_LOGIC;
        Refroidir_Surveillance : out STD_LOGIC;
        Irriguer_Surveillance : out STD_LOGIC
        );
	 end component;
	 component Bloc_Controle
	 Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        capteur_NE : in STD_LOGIC;
        capteur_PH : in STD_LOGIC_VECTOR(2 downto 0);
        Alarme_NE : out STD_LOGIC;
        Alarme_PH : out STD_LOGIC
    );
	 end component;
	 component Bloc_Act
	 Port (
        -- Inputs
        pompe_actif_BlockAct : in STD_LOGIC;
        ventilo_actif_BlockAct  : in STD_LOGIC;
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        -- Outputs
        FIN_BlockAct : out STD_LOGIC;
		  POMPE_BlockAct : out STD_LOGIC;
        VENTILO_BlockAct : out STD_LOGIC
    );
	 end component;
	 
begin
    -- Connect the blocks and signals
   -- Instantiate Bloc_temps entity
Bloc_temps_inst : Bloc_temps
    Port Map (
        Temps_manuelle => Temps_manuelle,  -- Connect to your actual signal or constant
        Capteur_Temp => Capteur_Temp,
        Capteur_Hum => Capteur_Hum,
        Seuils_Hum => Seuils_Hum,
        Seuil_Temp => Seuil_Temp,
        I_manuelle => I_manuelle,
        Refroidir => Refroidir_BlockTemps,
        Irriguer => Irriguer_BlockTemps,
        clk => clk,  -- Connect to your actual signal or constant
        rst => rst,
		  Pompe_actif => Pompe_actif,
        Ventilo_actif => Ventilo_actif
    );


    Bloc_surveillance_inst : Bloc_surveillance
        Port Map (
            clk => clk,
            rst => rst,
            Capteur_Temp => Capteur_Temp,
            Capteur_Hum => Capteur_Hum,
            Seuils_Hum => Seuils_Hum,
            Seuil_Temp => Seuil_Temp,
            Refroidir_Surveillance => Refroidir_Surveillance,
            Irriguer_Surveillance => Irriguer_Surveillance,
			   Alarme_T_Surveillance => alarme_T,
            Alarme_HI_Surveillance => alarme_HI,
            Alarme_HS_Surveillance => alarme_HS
            -- Connect other ports as needed
        );

    Bloc_Controle_inst : Bloc_Controle
        Port Map (
            clk => clk,
            rst => rst,
            capteur_NE => Capteur_Niveau_Eau,
            capteur_PH => Capteur_pH,
				Alarme_NE => alarme_NE,
            Alarme_PH => alarme_PH
              );

    Bloc_Act_inst : Bloc_Act
        Port Map (
            pompe_actif_BlockAct  => pompe_actif_BlockAct,
            ventilo_actif_BlockAct  => ventilo_actif_BlockAct,
            clk => clk,
            rst => rst,
				FIN_BlockAct => fin,
		      POMPE_BlockAct => pompe,
            VENTILO_BlockAct => ventilo 
				
        );

    -- Define additional interconnections here
    Refroidir_BlockTemps <= Refroidir_Surveillance ;
	 Irriguer_BlockTemps <= Irriguer_Surveillance ;
	 
    pompe_actif_BlockAct <= Pompe_actif ;
    ventilo_actif_BlockAct <= Ventilo_actif ;

	 
        


end Behavioral;
