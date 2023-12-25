----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 09:58:59 AM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
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

entity Reg_Bank is
    Port ( Clk : in STD_LOGIC;
           Reg_EN : in STD_LOGIC_VECTOR (2 downto 0);
           Reset :in STD_LOGIC;
           Reg_Bank_In : in STD_LOGIC_VECTOR (3 downto 0);
           REG_0_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_1_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_2_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_3_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_4_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_5_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_6_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           REG_7_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_Bank;

architecture Behavioral of Reg_Bank is
component REG
    port( 
        D : in STD_LOGIC_VECTOR (3 downto 0);
        En : in STD_LOGIC;
        Clk : in STD_LOGIC;
        Reset :in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (3 downto 0)
     );   
 end component;
 
 component Decoder_3_to_8 
        Port ( 
        I : in STD_LOGIC_VECTOR (2 downto 0);
        EN : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR (7 downto 0)
        );  
 end component;
 
 signal decoder_out :  std_LOGIC_VECTOR(7 downto 0);
  
begin

    Reg_Bank_Decoder : Decoder_3_to_8
        port map(
            I => Reg_EN,
            EN => '1',
            Y => decoder_out
            );
        
  REG_0 : REG
        port map(
           D => "0000",
           EN=> decoder_out(0),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_0_OUT
          );
    REG_1 : REG
        port map(
           D => Reg_Bank_In,
           EN=> decoder_out(1),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_1_OUT
           );
     REG_2 : REG
        port map(
           D => Reg_Bank_In,
           EN=> decoder_out(2),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_2_OUT
           );
    REG_3 : REG
         port map(
           D => Reg_Bank_In,
           EN=> decoder_out(3),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_3_OUT
           );
     REG_4 : REG
         port map(
           D => Reg_Bank_In,
           EN=> decoder_out(4),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_4_OUT
           );
     REG_5 : REG
          port map(
           D => Reg_Bank_In,
           EN=> decoder_out(5),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_5_OUT
           );
     REG_6 : REG
          port map(
           D => Reg_Bank_In,
           EN=> decoder_out(6),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_6_OUT
           );  
     REG_7 : REG
          port map(
           D =>Reg_Bank_In,
           EN=> decoder_out(7),
           Clk => Clk,
           Reset=>Reset,
           Q=> REG_7_OUT
           );     
                                          
end Behavioral;
