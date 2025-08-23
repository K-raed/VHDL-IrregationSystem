library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Bloc_Controle is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        capteur_NE : in STD_LOGIC;
        capteur_PH : in STD_LOGIC_VECTOR(2 downto 0);
        Alarme_NE : out STD_LOGIC;
        Alarme_PH : out STD_LOGIC
    );
end Bloc_Controle;

architecture behavior of Bloc_Controle is
    signal pH_Trop_Eleve : STD_LOGIC := '0';
    signal Niveau_Eau_Bas : STD_LOGIC := '0';
begin
    process(clk, rst, capteur_NE, capteur_PH)
    begin
        if (rst = '1') then
            pH_Trop_Eleve <= '0';
            Niveau_Eau_Bas <= '0';
        elsif rising_edge(clk) then
            if (capteur_NE = '0') then
                Niveau_Eau_Bas <= '1'; -- Niveau d'eau bas
            else
                Niveau_Eau_Bas <= '0';
            end if;

            if (capteur_PH > "111") then
                pH_Trop_Eleve <= '1'; -- pH trop élevé (supérieur à 7)
            else
                pH_Trop_Eleve <= '0';
            end if;
        end if;
    end process;

    Alarme_NE <= Niveau_Eau_Bas;
    Alarme_PH <= pH_Trop_Eleve;

end behavior;
