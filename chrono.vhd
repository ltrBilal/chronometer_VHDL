library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity chrono is
    port (
         clk : in std_logic;
         reset : in std_logic;
         start : in std_logic;
         pause : in std_logic;
         rec : in std_logic; -- Enregistrement de l'état de comptage dans REGISTRE_MS et REGISTRE_S
         cpt_ms_out : out unsigned(9 downto 0);
         cpt_s_out : out unsigned(5 downto 0)
    );
end chrono;

architecture archi_chrono of chrono is
    signal eoc_int : std_logic;
    signal cpt_ms_int : unsigned(9 downto 0);
    signal cpt_s_int :  unsigned(5 downto 0);
    signal previous_rec : std_logic := '0';
    signal rec_int : std_logic := '0';

    signal enable_loading_int : std_logic := '0';
begin 

    process (rec, previous_rec)
    begin
        if previous_rec /= rec then
            previous_rec <= rec;
            rec_int <= '1';
        else 
            rec_int <= '0';
        end if;
    end process;

    -- instancier TIMER_MS
    timer_ms_inst: entity work.timer_ms(arch_timer_ms)
     port map(
        clk => clk,
        raz => reset,
        start => start,
        pause => pause,
        eos => eoc_int,
        count_ms => cpt_ms_int,
        enable_loading => enable_loading_int
    );

    --instancier TIMER_S
    timer_s_inst: entity work.timer_s(arch_timer_s)
     port map(
        clk => clk,
        eoc => eoc_int,
        raz => reset,
        count_s => cpt_s_int
    );

    -- instancier REG_MS
    registre_ms_inst: entity work.registre_ms(arch_reg_ms)
     port map(
        reset => reset,
        load => rec_int,
        ms_in => cpt_ms_int,
        ms_out => cpt_ms_out,
        enable_loading => enable_loading_int
    );

    -- instancier REG_S
    registre_s_inst: entity work.registre_s(arch_reg_s)
     port map(
        reset => reset,
        load => rec_int,
        s_in => cpt_s_int,
        s_out => cpt_s_out
    );
    
end archi_chrono;