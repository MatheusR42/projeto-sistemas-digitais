library ieee;
use ieee.std_logic_1164.all;

entity quartus_moore is
   port (
      KEY    : in std_logic_vector(1 downto 0); 
      SW     : in std_logic_vector(1 downto 0);
      LEDR   : out std_logic_vector(2 downto 0);
      HEX0   : out std_logic_vector(6 downto 0);
      HEX1   : out std_logic_vector(6 downto 0);
      HEX2   : out std_logic_vector(6 downto 0);
      HEX3   : out std_logic_vector(6 downto 0);
      HEX4   : out std_logic_vector(6 downto 0);
      HEX5   : out std_logic_vector(6 downto 0);
		Z      : out std_logic
   );

end quartus_moore;

architecture process_3 of quartus_moore is
   type state_type is (A, B, C, D, E);
   signal state : state_type := A;
   signal x : std_logic := '0';
   signal reset : std_logic := '0';
begin

   input_control: process (KEY(0), KEY(1))
		variable tmp: std_logic := '0';
		begin
			if KEY(1) = '0' then
				state <= A;
			elsif rising_edge(KEY(0)) then
				tmp := SW(0);
				
				case state is
					when A =>
						if tmp = '1' then
							state <= B;
						else
							state <= A;
						end if;
					when B =>
						if tmp = '1' then
							state <= C;
						else
							state <= A;
						end if;
					when C =>
						if tmp = '1' then
							state <= C;
						else
							state <= D;
						end if;
					when D =>
						if tmp = '1' then
							state <= E;
						else
							state <= A;
						end if;
					when E =>
						if tmp = '1' then
							state <= C;
						else
							state <= A;
						end if;
				end case;
			end if;
		end process;

   -- Process: 7-segment display control for HEX0 to HEX5
   seg7_control: process(state)
   begin
      if state = E then
         HEX5 <= "1111001"; -- 1
         HEX4 <= "1111111"; -- blank
         HEX3 <= "1111111"; -- blank
         HEX2 <= "1111111"; -- blank
         HEX1 <= "1111111"; -- blank
         HEX0 <= "0000110"; -- E
      elsif state = D then
         HEX5 <= "1000000"; -- 0
         HEX4 <= "1111111"; -- blank
         HEX3 <= "1111111"; -- blank
         HEX2 <= "1111111"; -- blank
         HEX1 <= "1111111"; -- blank
         HEX0 <= "0100001"; -- D
		elsif state = C then
         HEX5 <= "1000000"; -- 0
         HEX4 <= "1111111"; -- blank
         HEX3 <= "1111111"; -- blank
         HEX2 <= "1111111"; -- blank
         HEX1 <= "1111111"; -- blank
         HEX0 <= "1000110"; -- C
		elsif state = B then
         HEX5 <= "1000000"; -- 0
         HEX4 <= "1111111"; -- blank
         HEX3 <= "1111111"; -- blank
         HEX2 <= "1111111"; -- blank
         HEX1 <= "1111111"; -- blank
         HEX0 <= "0000011"; -- b
		else
         HEX5 <= "1000000"; -- 0
         HEX4 <= "1111111"; -- blank
         HEX3 <= "1111111"; -- blank
         HEX2 <= "1111111"; -- blank
         HEX1 <= "1111111"; -- blank
         HEX0 <= "0001000"; -- A
      end if;
   end process;
   
	
   output_func: process (state)
   begin
      case state is
         when E =>
            Z <= '1';
         when others =>
            Z <= '0';
      end case;
   end process;
	
end process_3;
