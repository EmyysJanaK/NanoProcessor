----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:16:43 AM
-- Design Name: 
-- Module Name: MUX_8_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_8_4bit is
    Port ( Reg_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           Mux_Out  : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_8_4bit;

architecture Behavioral of MUX_8_4bit is
component Decoder_3_to_8
    port(I : in STD_LOGIC_VECTOR (2 downto 0);
    EN : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal Decoder_Out : std_logic_vector(7 downto 0);
signal Mux_Output : std_logic_vector(3 downto 0);
signal D0 : std_logic_vector(3 downto 0);
signal A0 : std_logic_vector(3 downto 0);
signal D1 : std_logic_vector(3 downto 0);
signal A1 : std_logic_vector(3 downto 0);
signal D2 : std_logic_vector(3 downto 0);
signal A2 : std_logic_vector(3 downto 0);
signal D3 : std_logic_vector(3 downto 0);
signal A3 : std_logic_vector(3 downto 0);
signal D4 : std_logic_vector(3 downto 0);
signal A4 : std_logic_vector(3 downto 0);
signal D5 : std_logic_vector(3 downto 0);
signal A5 : std_logic_vector(3 downto 0);
signal D6 : std_logic_vector(3 downto 0);
signal A6 : std_logic_vector(3 downto 0);
signal D7 : std_logic_vector(3 downto 0);
signal A7 : std_logic_vector(3 downto 0);


begin
Decoder_3_to_8_0 : Decoder_3_to_8
    port map (
        I => Reg_Sel,
        EN => '1',
        Y => Decoder_Out
    );
    D0 <= R0 AND A0;
    D1 <= R1 AND A1;
    D2 <= R2 AND A2;
    D3 <= R3 AND A3;
    D4 <= R4 AND A4;
    D5 <= R5 AND A5;
    D6 <= R6 AND A6;
    D7 <= R7 AND A7;
    
    A0 <= (others=> Decoder_Out(0));
    A1 <= (others=> Decoder_Out(1)); 
    A2 <= (others=> Decoder_Out(2));
    A3 <= (others=> Decoder_Out(3));
    A4 <= (others=> Decoder_Out(4)); 
    A5 <= (others=> Decoder_Out(5));
    A6 <= (others=> Decoder_Out(6)); 
    A7 <= (others=> Decoder_Out(7));
    


    Mux_Out <= D0 or D1 or D2 or D3 or D4 or D5 or D6 or D7;

end Behavioral;
