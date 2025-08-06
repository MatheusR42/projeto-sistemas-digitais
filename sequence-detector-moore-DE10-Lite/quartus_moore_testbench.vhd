-- Testbench for quartus_moore - Sequence Detector
library ieee;
use ieee.std_logic_1164.all;

entity quartus_moore_testbench is
end quartus_moore_testbench;

architecture tb_arch of quartus_moore_testbench is
   signal KEY  : std_logic_vector(1 downto 0);
   signal SW   : std_logic_vector(1 downto 0);
   signal LEDR : std_logic_vector(2 downto 0);
   signal Z    : std_logic;
begin

   -- Instantiate the Unit Under Test (UUT)
   uut: entity work.quartus_moore(process_3)
      port map (
         KEY  => KEY,
         SW   => SW,
         LEDR => LEDR,
         HEX0 => open,
         HEX1 => open,
         HEX2 => open,
         HEX3 => open,
         HEX4 => open,
         HEX5 => open,
         Z    => Z
      );

   -- Stimulus process: generates test vectors

   stimulus_process: process
   begin
      -- Initialize
      KEY(1) <= '0'; -- Assert reset
      KEY <= "11";
      SW <= "00";
      wait for 10 ns;

      KEY(1) <= '1'; -- Deassert reset
      wait for 10 ns;

      -- Send bit sequence: 1 1 0 1 -> should detect 1101 → Z='1'

      SW(0) <= '1'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '0'; wait for 10 ns;      

      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '1'; wait for 10 ns;      

      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      -- now we already have 1 from the last sequence, so let add 1 0 1 to detect again
      SW(0) <= '1'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '0'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '1'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge
     
      -- now a wrong sequence, so let add 0 1 1
      SW(0) <= '0'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '1'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge

      SW(0) <= '1'; wait for 10 ns;      
      KEY(0) <= '0'; wait for 10 ns; -- Rising edge
      KEY(0) <= '1'; wait for 10 ns; -- Falling edge
     
      wait;
   end process;

end tb_arch;
