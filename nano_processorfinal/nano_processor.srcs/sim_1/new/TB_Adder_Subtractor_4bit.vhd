library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Adder_Subtractor_4bit is

end TB_Adder_Subtractor_4bit;

architecture Behavioral of TB_Adder_Subtractor_4bit is
    -- Component declaration for the DUT (Device Under Test)
    component Adder_Subtractor_4bit
        Port (
            A       : in  STD_LOGIC_VECTOR (3 downto 0);
            B       : in  STD_LOGIC_VECTOR (3 downto 0);
            M       : in  STD_LOGIC;
            S       : out STD_LOGIC_VECTOR (3 downto 0);
            C_OUT   : out STD_LOGIC;
            OVERFLOW: out STD_LOGIC;
            ZERO    : out STD_LOGIC
        );
    end component;

    -- Signal declarations
    signal A_tb       : STD_LOGIC_VECTOR (3 downto 0);
    signal B_tb       : STD_LOGIC_VECTOR (3 downto 0);
    signal M_tb       : STD_LOGIC;
    signal S_tb       : STD_LOGIC_VECTOR (3 downto 0);
    signal C_OUT_tb   : STD_LOGIC;
    signal OVERFLOW_tb: STD_LOGIC;
    signal ZERO_tb    : STD_LOGIC;

begin

    -- Instantiate the DUT
    uut: Adder_Subtractor_4bit
    port map (
        A        => A_tb,
        B        => B_tb,
        M        => M_tb,
        S        => S_tb,
        C_OUT    => C_OUT_tb,
        OVERFLOW => OVERFLOW_tb,
        ZERO     => ZERO_tb
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        A_tb <= "0000";
        B_tb <= "0000";
        M_tb <= '0';
        wait for 10 ns;

        -- Test case 2
        A_tb <= "1010";
        B_tb <= "0011";
        M_tb <= '1';
        wait for 10 ns;

        -- Test case 3
        A_tb <= "1111";
        B_tb <= "0101";
        M_tb <= '0';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
