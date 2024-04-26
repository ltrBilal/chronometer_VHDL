library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity registre_s is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        s_in : in unsigned(5 downto 0); -- pour qu'on puisse compter jusqu'à 59, on a besoin de 6 bits
        s_out : out unsigned(5 downto 0) := (others => '0')
    );
end entity;

architecture arch_reg_s of registre_s is
    
begin
    
    process (reset, load, s_in)
    begin
        if reset = '1' then
            s_out <= (others => '0');
        elsif load = '1' then
            s_out <= s_in;
        end if;
    end process;
    
end architecture arch_reg_s;