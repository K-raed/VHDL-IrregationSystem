library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Bloc_surveillance is
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
        );end Bloc_surveillance ;

architecture behavior of Bloc_surveillance is

    signal alarme_T, alarme_HI, alarme_HS, refroidir, irriguer : STD_LOGIC ;
Begin
    process (clk, rst, Capteur_Temp, Seuil_Temp, Capteur_Hum, Seuils_Hum)
    begin
        if (rst = '1') then
		      alarme_T <= ('0');
            alarme_HI <= ('0');
            alarme_HS <= ('0');
            refroidir <= ('0');
            irriguer <= ('0');
				
        elsif rising_edge(clk) then
            if (Capteur_Temp > Seuil_Temp) then
                alarme_T <= '1'; -- Activation de l'alarme de température
                refroidir <= '1'; -- Activation du signal de refroidissement
            else
                alarme_T <= '0';
                refroidir <= '0';
            end if;

            if (Capteur_Hum < Seuils_Hum(6 downto 0)) then
                alarme_HI <= '1'; -- Activation de l'alarme d'humidité inférieure
                irriguer <= '1'; -- Activation du signal d'irrigation
            else
                alarme_HI <= '0';
                irriguer <= '0';
            end if;

            if (Capteur_Hum > Seuils_Hum(13 downto 7)) then
                alarme_HS <= '1'; -- Activation de l'alarme d'humidité supérieure
                irriguer <= '1'; -- Activation du signal d'irrigation
            else
                alarme_HS <= '0';
            end if;
        end if;
		  
    end process;

    -- Assign corrected signal names to outputs
    Alarme_T_Surveillance <= alarme_T ;
    Alarme_HI_Surveillance <= alarme_HI ;
    Alarme_HS_Surveillance <= alarme_HS ;
    Refroidir_Surveillance <= refroidir ;
    Irriguer_Surveillance <= irriguer ;

end behavior;
