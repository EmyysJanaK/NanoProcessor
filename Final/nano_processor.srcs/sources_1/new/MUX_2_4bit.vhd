----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 10:18:45 AM
-- Design Name: 
-- Module Name: MUX_2_4bit - Behavioral
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

    entity MUX_2_4bit is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Q : out STD_LOGIC_VECTOR (3 downto 0);
               S : in STD_LOGIC);
    end MUX_2_4bit;

    architecture Behavioral of MUX_2_4bit is

    signal ls_s : std_logic;
    signal asu_s : std_logic_vector(3 downto 0);
    signal immVal_s : std_logic_vector(3 downto 0);
    signal output : std_logic_vector(3 downto 0);
    begin

        ls_s <= S;
        asu_s <= B;
        immVal_s <= A;
        process (ls_s, asu_s, immVal_s) begin
            if ls_s='1' then
                output<=asu_s;
            else 
                output<=immVal_s;
            end if;
        end process;
        
        Q <= output;
    end Behavioral;
