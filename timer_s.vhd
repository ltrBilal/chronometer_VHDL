library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity timer_s is
    port (
        clk   : in std_logic;
        eoc : in std_logic; -- pour synchroniser l'incrémentation du TIMER_S en fonction de TIMER_MS
        raz : in std_logic;
        count_s : out unsigned(5 downto 0)
    );
end entity;

architecture arch_timer_s of timer_s is
    signal compteur : integer := 0;
begin
    process (clk, raz, eoc, compteur)
        begin
            if rising_edge(clk) then
                if raz = '1' then
                    compteur <= 0;
                elsif eoc = '1' then -- pour incrémenter le nombre de seconde
                    compteur <= compteur + 1;
                end if;
            end if;
    end process;

    count_s <= to_unsigned(compteur, 6);
end arch_timer_s;