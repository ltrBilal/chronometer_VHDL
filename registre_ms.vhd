library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity registre_ms is
    port (
        reset : in std_logic;
        load : in std_logic;
        enable_loading : in std_logic;
        ms_in : in unsigned(9 downto 0) := (others => '0'); -- pour qu'on puisse compter jusqu'à 999, on a besoin de 10 bits
        ms_out : out unsigned(9 downto 0)
    );
end entity;

architecture arch_reg_ms of registre_ms is
    
begin
    
    process (reset, load, ms_in, enable_loading)
    begin
        if reset = '1' then
            ms_out <= (others => '0');
        elsif load = '1' and enable_loading = '1' then
            if ms_in = 0 then
                ms_out <= ms_in;
            else 
                ms_out <= ms_in - 1;
            end if;
        end if;
    end process;
    
end architecture arch_reg_ms;