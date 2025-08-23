library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Bloc_Act is
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
end Bloc_Act;

architecture behavior of Bloc_Act is
    signal FIN,POMPE,VENTILO : STD_LOGIC := '0' ;
begin
    process(clk, rst, pompe_actif_BlockAct, ventilo_actif_BlockAct)
    begin
        if (rst = '1') then
            FIN <= '0';
				POMPE <= '0';
				VENTILO <= '0';
        elsif rising_edge(clk) then
            if (ventilo_actif_BlockAct = '1') then
                VENTILO <= '1' ; 
					 if (ventilo_actif_BlockAct = '0') then
					 FIN <= '1' ; 
					 end if ;
            else
                VENTILO <= '0';
            end if;
				
				if (pompe_actif_BlockAct = '1') then
                POMPE <= '1' ; 
					 if (pompe_actif_BlockAct = '0') then
					 FIN <= '1' ; 
					 end if ;
            else
                POMPE <= '0';
            end if;

            
        end if;
    end process;

    FIN_BlockAct <= FIN ;
	 POMPE_BlockAct <= POMPE ;
	 VENTILO_BlockAct <= VENTILO ;

end behavior ;
