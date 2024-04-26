library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity registre_ms is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        ms_in : in unsigned(9 downto 0); -- pour qu'on puisse compter jusqu'à 999, on a besoin de 10 bits
        ms_out : out unsigned(9 downto 0) := (others => '0')
    );
end entity;

architecture arch_reg_ms of registre_ms is
    
begin
    
    process (reset, load, ms_in)
    begin
        if reset = '1' then
            ms_out <= (others => '0');
        elsif load = '1' then
            ms_out <= ms_in;
        end if;
    end process;
    
end architecture arch_reg_ms;