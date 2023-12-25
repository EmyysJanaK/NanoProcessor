
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder_Subtractor_4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0); --input A
           B : in STD_LOGIC_VECTOR (3 downto 0); --input B
           M : in STD_LOGIC;                     -- Adder Subtractor switch
           S : out STD_LOGIC_VECTOR (3 downto 0);--Output
           C_OUT : out STD_LOGIC;                --Carry or Borrow out
           OVERFLOW: out STD_LOGIC;              --Overflow Flag
           ZERO: out STD_LOGIC                   --Zero Flag
           );                
end Adder_Subtractor_4bit;

architecture Behavioral of Adder_Subtractor_4bit is
    component FA 
        port ( 
        A: in std_logic; 
        B: in std_logic; 
        C_in: in std_logic; 
        S: out std_logic; 
        C_out: out std_logic); 
    end component;
     
    SIGNAL FA0_C, FA1_C, FA2_C, FA3_C,CARRY: std_logic; 
    SIGNAL B_temp:STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL S_temp:STD_LOGIC_VECTOR (3 downto 0);
begin
    
    FA_0 : FA
        port map ( 
             A => A(0), 
             B => B_temp(0), 
             C_in => M ,
             S => S_temp(0), 
             C_out => FA0_C); 

    FA_1 : FA 
        port map ( 
             A => A(1), 
             B => B_temp(1), 
             C_in => FA0_C, 
             S => S_temp(1), 
             C_out => FA1_C); 

     FA_2 : FA 
         port map ( 
             A => A(2), 
             B => B_temp(2), 
             C_in => FA1_C, 
             S => S_temp(2), 
             C_out => FA2_C); 

     FA_3 : FA 
         port map ( 
             A => A(3), 
             B => B_temp(3), 
             C_in => FA2_C, 
             S => S_temp(3), 
             C_out => CARRY);


    B_temp(0)<=B(0) XOR M;         
    B_temp(1)<=B(1) XOR M;             
    B_temp(2)<=B(2) XOR M;             
    B_temp(3)<=B(3) XOR M;

     C_OUT<=CARRY;
     S<=S_temp;

     ZERO <=NOT S_temp(0) AND NOT S_temp(1) AND NOT S_temp(2) AND NOT S_temp(3) AND CARRY;
     
     OVERFLOW<= M AND NOT(FA2_C AND (A(3) XOR B_temp(3)));
     
end Behavioral;
