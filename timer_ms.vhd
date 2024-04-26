library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity timer_ms is
    port (
        clk   : in std_logic;
        start : in std_logic; -- pour commencer le comptage
        pause : in std_logic; -- arrÃªter le comptage
        raz : in std_logic; -- remiz Ã  zÃ©ro
        count_ms : out unsigned(9 downto 0);
        eos : out std_logic; -- pour passer à  la seconde suivant (mis à  jour le TIMER_S)
        enable_loading : out std_logic -- pour enregestrer  
    );
end entity;

architecture arch_timer_ms of timer_ms is
    signal start_counting : std_logic := '0';
    signal stop_counting : std_logic := '0';
    signal compteur : integer := 0;
    signal eos_int : std_logic; -- signal pour augmenter le nombre de seconde
begin

        process (clk, raz, start, pause, start_counting, stop_counting, compteur)
        begin

            -- initialiser le compteur
            if raz = '1' then
                compteur <= 0;
                eos_int <= '0';
                start_counting <= '0';
                stop_counting <= '0';

            -- mis a jour le signal "stop_counting" pour arrÃªter le compteur
            elsif pause = '1' and stop_counting = '0' then
                enable_loading <= '0';
                compteur <= compteur - 1;
                stop_counting <= '1';
                start_counting <= '0';

            -- mis a jour le signal "start_counting" pour déclencher le compteur
            elsif start = '1' and start_counting = '0' then
                enable_loading <= '1';
                compteur <= compteur + 1;
                start_counting <= '1';
                stop_counting <= '0';

            elsif rising_edge(clk) then
                eos_int <= '0';
                -- si pause est préssé, on fait rien (le compteur ne s'incrémente plus)
                if start_counting = '1' and stop_counting = '0' then -- le cas où start est préssé et pause n'est pas.
                    compteur <= compteur + 1; 
                    if compteur = 999 then --si le nombre de ms Ã©gale Ã  999
                        compteur <= 0;
                        eos_int <= '1';
                    end if;
                end if;
            end if;

        end process;

        eos <= eos_int;
        count_ms <= to_unsigned(compteur, 10);

end arch_timer_ms;