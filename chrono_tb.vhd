library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity chrono_tb is
end entity;

architecture arch_chrono_tb of chrono_tb is

    signal clk : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal pause : std_logic;
    signal rec : std_logic; -- Enregistrement de l'�tat de comptage dans REGISTRE_MS et REGISTRE_S
    signal cpt_ms_out : unsigned(9 downto 0);
    signal cpt_s_out : unsigned(5 downto 0);

begin
    chrono_inst: entity work.chrono(archi_chrono)
     port map(
        clk => clk,
        reset => reset,
        start => start,
        pause => pause,
        rec => rec,
        cpt_ms_out => cpt_ms_out,
        cpt_s_out => cpt_s_out
    );

    -- simulation d'horloge
    horloge_process : process
    begin
            clk <= '0';
            wait for 0.5 ms;
            clk <= '1';
            wait for 0.5 ms;
    end process;

    -- simulation pour RESET
    reset_process : process
    begin
        reset <= '0';
        wait for 65 ms;
        reset <= '1';
        wait for 1 ns;
        reset <= '0';
        wait;
    end process;

    -- simulation pour START
    start_process : process
    begin
        start <= '1';
        wait for 5 ms;
        start <= '0';
        wait for 30 ms;
        start <= '1';
        wait for 15 ms;
        start <= '0';
        wait for 25 ms;
        start <= '1';
        wait for 2 ms;
        start <= '0';
        wait;
    end process;

    -- simulation pour PAUSE
    pause_process : process
    begin
        pause <= '0';
        wait for 30 ms;
        pause <= '1';
        wait for 5 ms;
        pause <= '0';
        wait;
    end process;

    --simulation pour REC
    rec_process : process 
    begin
        rec <= '0';
        wait for 10 ms;
        rec <= '1';
        wait for 20 ms;
        rec <= '0';
        wait for 20 ms;
        rec <= '1';
        wait for 50 ms;
        rec <= '0';
        wait for 1 sec;
        rec <= '1';
        wait;
    end process;

end arch_chrono_tb;