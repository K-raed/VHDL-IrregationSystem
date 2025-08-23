library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Bloc_temps is
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
end Bloc_temps;

architecture behavior of Bloc_temps is
    signal p_actif : STD_LOGIC := '0';
	 signal v_actif : STD_LOGIC := '0';
	 signal duration: time;
Begin
    process (Capteur_Temp, Seuil_Temp, Capteur_Hum, Seuils_Hum, Temps_manuelle, I_manuelle, Refroidir, Irriguer, clk, rst)
    begin
--	 duration <= to_stdulogicvector(Temps_manuelle) ;
        if (rst = '1') then
            p_actif <= '0';
            v_actif <= '0';
            
        elsif rising_edge(clk) then
            if (Capteur_Temp > Seuil_Temp(4 downto 0)) then
                v_actif <= '1';                
		   	 else
                v_actif <= '0';
            end if;

            if (Capteur_Hum > Seuils_Hum(6 downto 0)) then
                p_actif <= '0'; 
            else
                p_actif <= '1'; 
            end if;

            if (Capteur_Hum < Seuils_Hum(13 downto 7)) then
                p_actif <= '0'; 
            else
                p_actif <= '1';
            end if;
			--	if (I_manuelle = '1')then 
			--	p_actif <= '1';
			--	WAIT FOR duration ;
         --   p_actif <= '0'; 
			--	end if; 
        end if;
    end process;

    Pompe_actif <= p_actif ;
    Ventilo_actif <= v_actif ;
end behavior;
